import XCTest
@testable import NetworkLayer

final class NetworkClientTests: XCTestCase {
    // MARK: - SUB
    var networkClient: NetworkClientImplementation!
    var mockSession: MockNetworkSession!
    var dataResponse: Data!
    
    // MARK: - Setup & tearDown
    override func setUp() {
        super.setUp()
        dataResponse = mockResponseData
    }
    
    override func tearDown() {
        mockSession = nil
        networkClient = nil
        super.tearDown()
    }
    
    func test_sendRequest_whenRequestIs_successful_withValidData() async {
        // Arrange
        let response = HTTPURLResponse(
            url: URL(string: "https://api.example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockSession = MockNetworkSession(data: dataResponse, response: response, error: nil)
        networkClient = NetworkClientImplementation(configuration: MockDefaultNetworkConfiguration(), session: mockSession)
        
        // Act
        do {
            let result = try await networkClient.send(MockGetCharacterRequest())
            // Assert
            XCTAssertEqual(result.results?.first?.id, 1)
        } catch {
            XCTFail("Expected Success, but got error: \(error)")
        }
    }
    
    func test_sendRequest_whenRequestIs_failed_withNoData_AndValidResponse() async {
        // Arrange
        let response = HTTPURLResponse(
            url: URL(string: "https://api.example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        mockSession = MockNetworkSession(data: nil, response: response, error: nil)
        networkClient = NetworkClientImplementation(configuration: MockDefaultNetworkConfiguration(), session: mockSession)
        
        // ACT
        do {
            let _ = try await networkClient.send(MockGetCharacterRequest())
            XCTFail("Expected to throw an error")
        } catch {
            // Assert
            if let networkError = error as? NetworkError {
                if case .invalidResponse = networkError {
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Expected NetworkError.decodingError, got: \(networkError)")
                }
            } else {
                XCTFail("Expected NetworkError, got: \(error)")
            }
        }
    }
    
    func test_sendRequest_withRetryInterceptor_threeTime_thenRequestIs_successful() async {
        // Arrange
        let mockInterceptor = MockRetryInterceptor()
        mockInterceptor.response = [
            .failure(NetworkError.serverError(statusCode: 1, error: nil)),
            .failure(NetworkError.serverError(statusCode: 1, error: nil)),
            .success(URLRequest(url: URL(string: "https://example.com")!))
        ]
        
        let retryInterceptor = RetryInterceptor(maxRetryCount: 3, requestInterceptor: mockInterceptor)
        
        // Act
        do {
            let request = URLRequest(url: URL(string: "https://example.com")!)
            let adaptRequest = try await retryInterceptor.adapt(request)
            // Assert
            XCTAssertEqual(adaptRequest.url?.absoluteString, "https://example.com")
            XCTAssertEqual(mockInterceptor.count, 3)
        } catch {
            XCTFail("Expected success after 3 retries, got error: \(error)")
        }
    }
    
    func test_sendRequest_withRetryInterceptor_threeTime_thenRequestIs_fail() async {
        // Arrange
        let mockInterceptor = MockRetryInterceptor()
        mockInterceptor.response = [
            .failure(NetworkError.serverError(statusCode: 1, error: nil)),
            .failure(NetworkError.serverError(statusCode: 1, error: nil)),
            .failure(NetworkError.serverError(statusCode: 1, error: nil))
        ]
        
        let retryInterceptor = RetryInterceptor(maxRetryCount: 3, requestInterceptor: mockInterceptor)
        
        // Act
        do {
            let request = URLRequest(url: URL(string: "https://example.com")!)
            let _ = try await retryInterceptor.adapt(request)
            XCTFail("Expected to fail after 3 retries)")
        } catch {
            // Assert
            XCTAssertEqual(mockInterceptor.count, 3)
            guard let networkError = error as? NetworkError else {
                XCTFail("Expected to be NetworkError, got: \(error)")
                return
            }
            if case .serverError(statusCode: 1, error: nil) = networkError {
                XCTAssertTrue(true)
            }
        }
    }
}
