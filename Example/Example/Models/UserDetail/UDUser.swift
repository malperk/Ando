//
//	UDUser.swift
//
//	Create by Alper KARATAS on 24/5/2017
//	Copyright © 2017 Fugo. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct UDUser{

	var bio : String!
	var firstName : String!
	var id : String!
	var lastName : String!
	var links : UDLink!
	var location : String!
	var name : String!
	var portfolioUrl : String!
	var profileImage : UDProfileImage!
	var totalCollections : Int!
	var totalLikes : Int!
	var totalPhotos : Int!
	var updatedAt : String!
	var username : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		bio = dictionary["bio"] as? String
		firstName = dictionary["first_name"] as? String
		id = dictionary["id"] as? String
		lastName = dictionary["last_name"] as? String
		if let linksData = dictionary["links"] as? [String:Any]{
				links = UDLink(fromDictionary: linksData)
			}
		location = dictionary["location"] as? String
		name = dictionary["name"] as? String
		portfolioUrl = dictionary["portfolio_url"] as? String
		if let profileImageData = dictionary["profile_image"] as? [String:Any]{
				profileImage = UDProfileImage(fromDictionary: profileImageData)
			}
		totalCollections = dictionary["total_collections"] as? Int
		totalLikes = dictionary["total_likes"] as? Int
		totalPhotos = dictionary["total_photos"] as? Int
		updatedAt = dictionary["updated_at"] as? String
		username = dictionary["username"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if bio != nil{
			dictionary["bio"] = bio
		}
		if firstName != nil{
			dictionary["first_name"] = firstName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lastName != nil{
			dictionary["last_name"] = lastName
		}
		if links != nil{
			dictionary["links"] = links.toDictionary()
		}
		if location != nil{
			dictionary["location"] = location
		}
		if name != nil{
			dictionary["name"] = name
		}
		if portfolioUrl != nil{
			dictionary["portfolio_url"] = portfolioUrl
		}
		if profileImage != nil{
			dictionary["profile_image"] = profileImage.toDictionary()
		}
		if totalCollections != nil{
			dictionary["total_collections"] = totalCollections
		}
		if totalLikes != nil{
			dictionary["total_likes"] = totalLikes
		}
		if totalPhotos != nil{
			dictionary["total_photos"] = totalPhotos
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

}