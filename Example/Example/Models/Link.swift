//
//	Link.swift
//

import Foundation

struct Link{

	var photos : String!
	var me : String!
	var download : String!
	var html : String!
	var likes : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		photos = dictionary["photos"] as? String
		me = dictionary["self"] as? String
		download = dictionary["download"] as? String
		html = dictionary["html"] as? String
		likes = dictionary["likes"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if photos != nil{
			dictionary["photos"] = photos
		}
		if me != nil{
			dictionary["self"] = me
		}
		if download != nil{
			dictionary["download"] = download
		}
		if html != nil{
			dictionary["html"] = html
		}
		if likes != nil{
			dictionary["likes"] = likes
		}
		return dictionary
	}

}
