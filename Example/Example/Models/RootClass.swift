//
//	RootClass.swift
//	

import Foundation

struct RootClass{

	var categories : [Category]!
	var color : String!
	var createdAt : String!
	var currentUserCollections : [AnyObject]!
	var height : Int!
	var id : String!
	var likedByUser : Bool!
	var likes : Int!
	var links : Link!
	var urls : Url!
	var user : User!
	var width : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		categories = [Category]()
		if let categoriesArray = dictionary["categories"] as? [[String:Any]]{
			for dic in categoriesArray{
				let value = Category(fromDictionary: dic)
				categories.append(value)
			}
		}
		color = dictionary["color"] as? String
		createdAt = dictionary["created_at"] as? String
		currentUserCollections = dictionary["current_user_collections"] as? [AnyObject]
		height = dictionary["height"] as? Int
		id = dictionary["id"] as? String
		likedByUser = dictionary["liked_by_user"] as? Bool
		likes = dictionary["likes"] as? Int
		if let linksData = dictionary["links"] as? [String:Any]{
				links = Link(fromDictionary: linksData)
			}
		if let urlsData = dictionary["urls"] as? [String:Any]{
				urls = Url(fromDictionary: urlsData)
			}
		if let userData = dictionary["user"] as? [String:Any]{
				user = User(fromDictionary: userData)
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
			var dictionaryElements = [[String:Any]]()
			for categoriesElement in categories {
				dictionaryElements.append(categoriesElement.toDictionary())
			}
			dictionary["categories"] = dictionaryElements
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
