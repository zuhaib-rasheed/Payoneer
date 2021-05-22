// Copyright (c) 2021 Payoneer Germany GmbH
// https://www.payoneer.com
//
// This file is open source and available under the MIT license.
// See the LICENSE file for more information.
import Foundation

/// List response with possible payment networks
class ListResult: NSObject, Decodable {
    /// Payment networks applicable for this `LIST` session.
    let networks: Networks
}
