//
//	UDRootClass.swift
//
//	Create by Alper KARATAS on 24/5/2017
//	Copyright © 2017 Fugo. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct UDRootClass{

	var categories : [AnyObject]!
	var color : String!
	var createdAt : String!
	var currentUserCollections : [AnyObject]!
	var height : Int!
	var id : String!
	var likedByUser : Bool!
	var likes : Int!
	var links : UDLink!
	var updatedAt : String!
	var urls : UDUrl!
	var user : UDUser!
	var width : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		categories = dictionary["categories"] as? [AnyObject]
		color = dictionary["color"] as? String
		createdAt = dictionary["created_at"] as? String
		currentUserCollections = dictionary["current_user_collections"] as? [AnyObject]
		height = dictionary["height"] as? Int
		id = dictionary["id"] as? String
		likedByUser = dictionary["liked_by_user"] as? Bool
		likes = dictionary["likes"] as? Int
		if let linksData = dictionary["links"] as? [String:Any]{
				links = UDLink(fromDictionary: linksData)
			}
		updatedAt = dictionary["updated_at"] as? String
		if let urlsData = dictionary["urls"] as? [String:Any]{
				urls = UDUrl(fromDictionary: urlsData)
			}
		if let userData = dictionary["user"] as? [String:Any]{
				user = UDUser(fromDictionary: userData)
			}
		width = dictionary["width"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if categories != nil{
			dictionary["categories"] = categories
		}
		if color != nil{
			dictionary["color"] = color
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if currentUserCollections != nil{
			dictionary["current_user_collections"] = currentUserCollections
		}
		if height != nil{
			dictionary["height"] = height
		}
		if id != nil{
			dictionary["id"] = id
		}
		if likedByUser != nil{
			dictionary["liked_by_user"] = likedByUser
		}
		if likes != nil{
			dictionary["likes"] = likes
		}
		if links != nil{
			dictionary["links"] = links.toDictionary()
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if urls != nil{
			dictionary["urls"] = urls.toDictionary()
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
		if width != nil{
			dictionary["width"] = width
		}
		return dictionary
	}

}