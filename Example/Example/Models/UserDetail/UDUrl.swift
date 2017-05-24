//
//	UDUrl.swift
//
//	Create by Alper KARATAS on 24/5/2017
//	Copyright © 2017 Fugo. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct UDUrl{

	var full : String!
	var raw : String!
	var regular : String!
	var small : String!
	var thumb : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		full = dictionary["full"] as? String
		raw = dictionary["raw"] as? String
		regular = dictionary["regular"] as? String
		small = dictionary["small"] as? String
		thumb = dictionary["thumb"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if full != nil{
			dictionary["full"] = full
		}
		if raw != nil{
			dictionary["raw"] = raw
		}
		if regular != nil{
			dictionary["regular"] = regular
		}
		if small != nil{
			dictionary["small"] = small
		}
		if thumb != nil{
			dictionary["thumb"] = thumb
		}
		return dictionary
	}

}