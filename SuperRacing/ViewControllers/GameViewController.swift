//
//  GameViewController.swift
//  PixelRacing
//
//  Created by Артур Кононович on 1.04.21.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    var alertView: AlertView!
    var terrainLayer = UIView()
    var roadLayer = UIView()
    
    var roadArray = [UIImageView]()
    var terrain = Terrain()
    var safeArea = CGRect()

    var spawnPointArray = [CGPoint]()
    var spawnPointWidth = CGFloat(0)
    
    var enemyArray = [UIImageView]()
    var enemyTimer = Timer()
    var collisionTimer = Timer()
    
    var speedMultiply = 1.0
    var score = 0
    var scoreLabel = UILabel()
    
    var player = UIImageView()
    var playerSpawnPoint = CGPoint()
    var isGrounded = true
    
    var isVCconfigured = false
    
    let motionManager = CMMotionManager()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !isVCconfigured {
            self.configureVC()
        }
    }
    
    func configureVC() {
        
        if GameManager.shared.settings.speed == .fast {
            self.speedMultiply = 0.5
        }
        
        self.terrainLayer = UIView(frame: self.view.frame)
        self.view.addSubview(terrainLayer)
        self.roadLayer = UIView(frame: self.view.frame)
        self.view.addSubview(roadLayer)
        self.safeArea = CGRect(x: 44, y: 0, width: self.view.frame.width - 88, height: self.view.frame.height)
        self.spawnPointWidth = (self.view.frame.width - 88) / 3
        self.playerSpawnPoint = CGPoint(x: roadLayer.frame.midX, y: roadLayer.frame.height - 155)
        
        self.createRoad()
        self.moveRoads(roadArray)
        self.calculateSpawnPoints()
        self.createPlayer()
        self.createEnemy()
        self.checkCollision()
        self.createScoreLabel()
        self.startMotionUpdate()
        self.startJumpUpdate()
        self.isVCconfigured = true
    }
    
    func createRoad() {
        self.createRoadPice()
        self.createRoadPice(y: -self.terrainLayer.frame.height)
        self.createRoadMarkings()
    }
    
    func createRoadPice(y: CGFloat = 0) {
        let road = UIImageView(frame: self.terrainLayer.frame)
        road.frame.origin.y = y
        road.backgroundColor = .darkGray
        road.image = self.terrain.road
        let leftSide = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: road.frame.height))
        leftSide.backgroundColor = .systemGreen
        leftSide.image = self.terrain.roadSide
        let rightSide = UIImageView(frame: CGRect(x: road.frame.width - 44, y: 0, width: 44, height: road.frame.height))
        rightSide.backgroundColor = .systemGreen
        rightSide.image = self.terrain.roadSide
        
        road.addSubview(leftSide)
        road.addSubview(rightSide)
        self.terrainLayer.addSubview(road)
        
        var position = CGFloat(0)
        
        while position + 25 < road.frame.height {
            position += CGFloat.random(in: 50...100)
            
            if position + 25 > road.frame.height {
                break
            }
            
            leftSide.addSubview(self.addTreesAndRocks(CGPoint(x: 0, y: position + CGFloat.random(in: (-25...25)))))
            rightSide.addSubview(self.addTreesAndRocks(CGPoint(x: 0, y: position + CGFloat.random(in: (-25...25)))))
        }
        
        self.roadArray.append(road)
    }
    
    func addTreesAndRocks(_ position: CGPoint) -> UIImageView {
        let imageView = UIImageView()
        let number = Int.random(in: 0...100)
        
        if number < 30 {
            imageView.image = self.terrain.rocks[Int.random(in: 0...self.terrain.rocks.count - 1)]
            imageView.frame = CGRect(origin: position, size: CGSize(width: CGFloat.random(in: 10...20), height: 5))
            imageView.frame.origin.x += CGFloat.random(in: 0...14)
        } else {
            imageView.image = self.terrain.trees[Int.random(in: 0...self.terrain.trees.count - 1)]
            imageView.frame = CGRect(origin: position, size: CGSize(width: 5, height: CGFloat.random(in: 40...50)))
            imageView.frame.origin.x += CGFloat.random(in: 10...20)
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        
        return imageView
    }
    
    func createRoadMarkings() {
        for road in roadArray {
            for index in 1...2 {
                let lineViewqs = UIImageView(image: self.terrain.roadLine)
                lineViewqs.frame.origin = CGPoint(x: 44 + spawnPointWidth * CGFloat(index) - 2, y: 0)
                lineViewqs.frame.size.width = CGFloat(4)
                lineViewqs.frame.size.height = road.frame.height
                lineViewqs.contentMode = .scaleToFill
                
                road.addSubview(lineViewqs)
            }
            
            let line = UIView()
            line.frame.origin = CGPoint(x: 48, y: 0)
            line.frame.size.width = CGFloat(4)
            line.frame.size.height = road.frame.height
            line.backgroundColor = .yellow
            
            road.addSubview(line)
            
            let line1 = UIView()
            line1.frame.origin = CGPoint(x: road.frame.width - 52, y: 0)
            line1.frame.size.width = CGFloat(4)
            line1.frame.size.height = road.frame.height
            line1.backgroundColor = .yellow
            
            road.addSubview(line1)
        }
    }
    
    func moveRoads(_ roadArray: [UIView]) {
        var roads = roadArray
        UIView.animate(withDuration: 5 * self.speedMultiply, delay: 0, options: .curveLinear) {
            roads[1].frame.origin.y += roads[1].frame.height
            roads[0].frame.origin.y += roads[0].frame.height
        } completion: { (_) in
            roads[0].frame.origin.y -= roads[0].frame.height * 2
            roads.swapAt(0, 1)
            self.moveRoads(roads)
        }
    }
    
    func calculateSpawnPoints() {
        for index in 0...2 {
            let spawnPoint = CGPoint(x: 44 + spawnPointWidth / 2 + spawnPointWidth * CGFloat(index), y: 0)
            self.spawnPointArray.append(spawnPoint)
        }
    }
    
    func createPlayer() {
        self.player.image = UIImage(named: GameManager.shared.settings.carImageName)
        self.player.contentMode = .scaleToFill
        self.player.frame.size = CGSize(width: 60, height: 100)
        self.player.center = playerSpawnPoint
        self.player.layer.zPosition = 100
        roadLayer.addSubview(self.player)
    }
    
    func createEnemy() {
        enemyTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            let enemy = UIImageView()
            enemy.frame.size = CGSize(width: 60, height: 100)
            enemy.center = self.spawnPointArray[Int.random(in: 0...2)]
            enemy.frame.origin.y -= enemy.frame.height
            enemy.image = GameManager.shared.getRandomCarImage()
            enemy.transform = .init(rotationAngle: .pi)
            self.roadLayer.addSubview(enemy)
            self.enemyArray.append(enemy)
            
            UIView.animate(withDuration: Double.random(in: 1.5...3) * self.speedMultiply, delay: 0, options: .curveLinear) {
                enemy.frame.origin.y += enemy.frame.height * 2 + self.roadLayer.frame.height
            } completion: { (_) in
                enemy.removeFromSuperview()
                self.incrementScore(step: 5)
            }
        }
    }
    
    func checkCollision() {
        collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { (timer) in
            guard let playerFrame = self.player.layer.presentation()?.frame else { return }
            
            self.incrementScore()
            
            if self.isGrounded {
                for enemy in self.enemyArray {
                    if let enemyFrame = enemy.layer.presentation()?.frame {
                        if playerFrame.intersects(enemyFrame) {
                            self.gameOver()
                        }
                    }
                }
                
                if playerFrame.intersection(self.safeArea).width < playerFrame.width {
                    self.gameOver()
                }
            }
            
        }
    }
    
    func gameOver() {
        let pausedTime: CFTimeInterval = self.roadLayer.layer.convertTime(CACurrentMediaTime(), from: nil)
        
        self.roadLayer.layer.speed = 0.0
        self.roadLayer.layer.timeOffset = pausedTime
        self.roadArray[0].layer.speed = 0.0
        self.roadArray[0].layer.timeOffset = pausedTime
        self.roadArray[1].layer.speed = 0.0
        self.roadArray[1].layer.timeOffset = pausedTime
        self.enemyTimer.invalidate()
        self.collisionTimer.invalidate()
        self.showAlert()
        self.motionManager.stopAccelerometerUpdates()
        self.motionManager.stopGyroUpdates()
        
        GameManager.shared.addNewScore(score: self.score)
    }
    
    func showAlert() {
        alertView = AlertView.instanceFromNib()
        alertView.titleLabel.text = "GAME OVER!".localized
        alertView.scoreLabel.text = "Score:".localized
        alertView.pointLabel.text = "\(self.score)"
        alertView.center = self.view.center
        alertView.alpha = 0
        alertView.delegate = self
    
        self.view.addSubview(alertView)
        
        UIView.animate(withDuration: 0.3) {
            self.alertView.alpha = 1
        }
    }
    
    func incrementScore(step: Int = 1) {
        self.score += step
        self.scoreLabel.text = String(format: "Score: %d".localized, self.score)
    }
    
    func createScoreLabel() {
        scoreLabel = UILabel(frame: CGRect(x: 20, y: 50, width: self.view.frame.width, height: 50))
        scoreLabel.textAlignment = .left
        scoreLabel.layer.zPosition = 100
        scoreLabel.setAttributedText(text: String(format: "Score: %d".localized, self.score), size: 30)
        roadLayer.addSubview(scoreLabel)
    }
    
    func startMotionUpdate() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data: CMAccelerometerData?, error: Error?) in
                if let acceleration = data?.acceleration {
                    self?.player.frame.origin.x += CGFloat(acceleration.x * 10.0)
                }
            }
        }
    }
    
    func startJumpUpdate() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                if let rate = data?.rotationRate {
                    
                    if rate.x < -3.0 && self.isGrounded {
                        self.isGrounded = false
                        self.jump()
                    }
                }
            }
        }
    }
    
    func jump() {
        UIView.animate(withDuration: 0.5) {
            self.player.frame.size.height += 20
            self.player.frame.size.width += 12
            self.player.frame.origin.x -= 6
            self.player.frame.origin.y -= 10
        } completion: { _ in
            self.fall()
        }
    }
    
    func fall() {
        UIView.animate(withDuration: 0.5) {
            self.player.frame.size.height -= 20
            self.player.frame.size.width -= 12
            self.player.frame.origin.x += 6
            self.player.frame.origin.y += 10
        } completion: { _ in
            self.isGrounded = true
        }
    }
    
    func restart() {
        score = 0
        scoreLabel.text = String(format: "Score: %d".localized, self.score)
        
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        self.roadArray.removeAll()
        self.enemyArray.removeAll()
        
        self.configureVC()
        
        self.motionManager.startAccelerometerUpdates()
        self.motionManager.startGyroUpdates()
    }
    
}

extension GameViewController: AlertViewDelegate {
    func menuButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func retryButtonPressed() {
        UIView.animate(withDuration: 0.3) {
            self.alertView.alpha = 0
        }
        self.alertView.removeFromSuperview()
        self.restart()
    }
}


