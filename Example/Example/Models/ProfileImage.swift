//
//	ProfileImage.swift
//	

import Foundation

struct ProfileImage{

	var large : String!
	var medium : String!
	var small : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		large = dictionary["large"] as? String
		medium = dictionary["medium"] as? String
		small = dictionary["small"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if large != nil{
			dictionary["large"] = large
		}
		if medium != nil{
			dictionary["medium"] = medium
		}
		if small != nil{
			dictionary["small"] = small
		}
		return dictionary
	}

}
