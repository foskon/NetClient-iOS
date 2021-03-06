//
//  NetAlamofire+Upload.swift
//  Net
//
//  Created by Alex Rupérez on 17/3/17.
//
//

import Alamofire

extension NetAlamofire {

    open func upload(_ streamedRequest: NetRequest) -> NetTask {
        let uploadRequest = sessionManager.upload(streamedRequest.bodyStream!, with: urlRequest(streamedRequest))
        uploadRequest.suspend()
        var netUploadTask: NetTask?
        uploadRequest.downloadProgress(queue: queue) { progress in
            netUploadTask?.progress = progress
            netUploadTask?.progressClosure?(progress)
        }
        uploadRequest.response(queue: queue) { [weak self] response in
            let netResponse = self?.netResponse(response.response, netUploadTask, response.data)
            let netError = self?.netError(response.error, response.data, response.response)
            netUploadTask?.response = netResponse
            netUploadTask?.error = netError
            #if !os(watchOS)
            if #available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *), let metrics = response.metrics {
                netUploadTask?.metrics = NetTaskMetrics(metrics, request: streamedRequest, response: netResponse)
            }
            #endif
            netUploadTask?.dispatchSemaphore?.signal()
            netUploadTask?.completionClosure?(netResponse, netError)
        }
        netUploadTask = netTask(uploadRequest)
        return netUploadTask!
    }

    open func upload(_ streamedRequest: URLRequest) throws -> NetTask {
        guard let netRequest = streamedRequest.netRequest else {
            throw netError(URLError(.badURL))!
        }
        return upload(netRequest)
    }

    open func upload(_ streamedURL: URL, cachePolicy: NetRequest.NetCachePolicy? = nil, timeoutInterval: TimeInterval? = nil) -> NetTask {
        return upload(netRequest(streamedURL, cache: cachePolicy, timeout: timeoutInterval))
    }

    open func upload(_ streamedURLString: String, cachePolicy: NetRequest.NetCachePolicy? = nil, timeoutInterval: TimeInterval? = nil) throws -> NetTask {
        guard let url = URL(string: streamedURLString) else {
            throw netError(URLError(.badURL))!
        }
        return upload(url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    }

    open func upload(_ request: NetRequest, data: Data) -> NetTask {
        let uploadRequest = sessionManager.upload(data, with: urlRequest(request))
        uploadRequest.suspend()
        var netUploadTask: NetTask?
        uploadRequest.downloadProgress(queue: queue) { progress in
            netUploadTask?.progress = progress
            netUploadTask?.progressClosure?(progress)
        }
        uploadRequest.response(queue: queue) { [weak self] response in
            let netResponse = self?.netResponse(response.response, netUploadTask, response.data)
            let netError = self?.netError(response.error, response.data, response.response)
            netUploadTask?.response = netResponse
            netUploadTask?.error = netError
            #if !os(watchOS)
            if #available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *), let metrics = response.metrics {
                netUploadTask?.metrics = NetTaskMetrics(metrics, request: request, response: netResponse)
            }
            #endif
            netUploadTask?.dispatchSemaphore?.signal()
            netUploadTask?.completionClosure?(netResponse, netError)
        }
        netUploadTask = netTask(uploadRequest)
        return netUploadTask!
    }

    open func upload(_ request: URLRequest, data: Data) throws -> NetTask {
        guard let netRequest = request.netRequest else {
            throw netError(URLError(.badURL))!
        }
        return upload(netRequest, data: data)
    }

    open func upload(_ url: URL, data: Data, cachePolicy: NetRequest.NetCachePolicy? = nil, timeoutInterval: TimeInterval? = nil) -> NetTask {
        return upload(netRequest(url, cache: cachePolicy, timeout: timeoutInterval), data: data)
    }

    open func upload(_ urlString: String, data: Data, cachePolicy: NetRequest.NetCachePolicy? = nil, timeoutInterval: TimeInterval? = nil) throws -> NetTask {
        guard let url = URL(string: urlString) else {
            throw netError(URLError(.badURL))!
        }
        return upload(url, data: data, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    }

    open func upload(_ request: NetRequest, fileURL: URL) -> NetTask {
        let uploadRequest = sessionManager.upload(fileURL, with: urlRequest(request))
        uploadRequest.suspend()
        var netUploadTask: NetTask?
        uploadRequest.downloadProgress(queue: queue) { progress in
            netUploadTask?.progress = progress
            netUploadTask?.progressClosure?(progress)
        }
        uploadRequest.response(queue: queue) { [weak self] response in
            let netResponse = self?.netResponse(response.response, netUploadTask, response.data)
            let netError = self?.netError(response.error, response.data, response.response)
            netUploadTask?.response = netResponse
            netUploadTask?.error = netError
            #if !os(watchOS)
            if #available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *), let metrics = response.metrics {
                netUploadTask?.metrics = NetTaskMetrics(metrics, request: request, response: netResponse)
            }
            #endif
            netUploadTask?.dispatchSemaphore?.signal()
            netUploadTask?.completionClosure?(netResponse, netError)
        }
        netUploadTask = netTask(uploadRequest)
        return netUploadTask!
    }

    open func upload(_ request: URLRequest, fileURL: URL) throws -> NetTask {
        guard let netRequest = request.netRequest else {
            throw netError(URLError(.badURL))!
        }
        return upload(netRequest, fileURL: fileURL)
    }

    open func upload(_ url: URL, fileURL: URL, cachePolicy: NetRequest.NetCachePolicy? = nil, timeoutInterval: TimeInterval? = nil) -> NetTask {
        return upload(netRequest(url, cache: cachePolicy, timeout: timeoutInterval), fileURL: fileURL)
    }

    open func upload(_ urlString: String, fileURL: URL, cachePolicy: NetRequest.NetCachePolicy? = nil, timeoutInterval: TimeInterval? = nil) throws -> NetTask {
        guard let url = URL(string: urlString) else {
            throw netError(URLError(.badURL))!
        }
        return upload(url, fileURL: fileURL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    }

}
