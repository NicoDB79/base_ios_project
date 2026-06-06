//
//  UseCaseResponse.swift
//  BaseProject
//
//  Created by Nicola De Bei on 19/01/23.
//

/*
import data

enum UseCaseResponseNullable<T: AnyObject> {
    case success(T?)
    case error(KotlinThrowable)
    
    static func fromEither(either: Either<T>) -> UseCaseResponseNullable {
        if either.isSuccess(), let either = either as? EitherSuccess {
            return .success(either.result)
            
        } else if either.isError(), let either = either as? EitherError {
            return .error(either.error)
            
        } else {
            return .error(KotlinThrowable(message: "Unexpected error"))
        }
    }
}

enum UseCaseResponse<T: AnyObject> {
    case success(T)
    case error(KotlinThrowable)
    
    static func fromEither(either: Either<T>) -> UseCaseResponse {
        if either.isSuccess(), let either = either as? EitherSuccess, let result = either.result {
            return .success(result)
            
        } else if either.isError(), let either = either as? EitherError {
            return .error(either.error)
            
        } else {
            return .error(KotlinThrowable(message: "Unexpected error"))
        }
    }
}
*/
