//
//	Category.swift
//	

import Foundation

struct Category{

	var id : Int!
	var links : Link!
	var photoCount : Int!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		if let linksData = dictionary["links"] as? [String:Any]{
				links = Link(fromDictionary: linksData)
			}
		photoCount = dictionary["photo_count"] as? Int
		title = dictionary["title"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if links != nil{
			dictionary["links"] = links.toDictionary()
		}
		if photoCount != nil{
			dictionary["photo_count"] = photoCount
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

}
