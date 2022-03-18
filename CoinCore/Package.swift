// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Targets: CaseIterable {
    case data
    case domain
    case networking
    case caching
    
    var name: String {
        switch self {
        case .data: return "Data"
        case .domain: return "Domain"
        case .networking: return "Networking"
        case .caching: return "Caching"
        }
    }
    
}

let package = Package(
    name: "CoinCore",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CoinCore",
            targets:Targets.allCases.map(\.name))
    ],
    targets: [
        .target(name: Targets.data.name,
                    dependencies: [.target(name: Targets.networking.name, condition: nil), .target(name: Targets.domain.name, condition: nil)]),
        
        .target(name: Targets.domain.name),
        .target(name: Targets.networking.name),
        .target(name: Targets.caching.name)
    ]
)
