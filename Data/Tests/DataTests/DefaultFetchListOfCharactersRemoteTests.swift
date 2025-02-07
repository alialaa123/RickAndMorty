import XCTest
import NetworkLayer
@testable import Data

class DefaultFetchListOfCharactersRemoteTests: XCTestCase {
    // MARK: - SUB
    var remote: DefaultGetListOfCharactersRemote!
    var mockNetworkClient: MockNetworkClient!
    
    // MARK: - Setup & tearDown
    override func setUp() {
        mockNetworkClient = MockNetworkClient()
        remote = DefaultGetListOfCharactersRemote(networkClient: mockNetworkClient)
        super.setUp()
    }
    
    override func tearDown() {
        remote = nil
        mockNetworkClient = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    func test_getListOfCharacters_withValidParams_shouldReturnListOfCharacters_success() async {
        // Arrange
        let expectedResponse = ListOfCharactersResponseDTO(
            results: [
                RickAndMortyCharacterDTO(
                    id: 1,
                    characterImage: "001.png",
                    characterName: "Ali",
                    species: "Human",
                    status: nil,
                    gender: nil
                ),
                RickAndMortyCharacterDTO(
                    id: 2,
                    characterImage: "002.png",
                    characterName: "Alaa",
                    species: "Human",
                    status: nil,
                    gender: nil
                ),
            ]
        )
        
        mockNetworkClient.setSendRequest(.success(expectedResponse))
        
        // Act
        do {
            let response = try await remote.getListOfCharacters(with: nil, page: 1)
            // Assert
            XCTAssertEqual(response.count, 2)
        } catch {
            XCTFail("Expected to succeed, but failed with error: \(error)")
        }
    }
    
    func test_getListOfCharacters_whenServerError_shouldThrowError() async {
        // Arrange
        mockNetworkClient.setSendRequest(.failure(NetworkError.serverError(statusCode: 404, error: nil)))
        
        // Act
        do {
            let response = try await remote.getListOfCharacters(with: nil, page: 1)
            XCTFail("Expected to fail, but got: \(response)")
        } catch {
            // Assert
            if let networkError = error as? NetworkError, case .serverError(statusCode: 404, error: nil) = networkError {
                XCTAssertTrue(true)
            } else {
                XCTFail("Expected NetworkError.serverError(statusCode: 404), but got: \(error)")
            }
        }
    }
}
