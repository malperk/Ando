//
//	User.swift
//	

import Foundation

struct User{

	var id : String!
	var links : Link!
	var name : String!
	var profileImage : ProfileImage!
	var username : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? String
		if let linksData = dictionary["links"] as? [String:Any]{
				links = Link(fromDictionary: linksData)
			}
		name = dictionary["name"] as? String
		if let profileImageData = dictionary["profile_image"] as? [String:Any]{
				profileImage = ProfileImage(fromDictionary: profileImageData)
			}
		username = dictionary["username"] as? String
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
		if name != nil{
			dictionary["name"] = name
		}
		if profileImage != nil{
			dictionary["profile_image"] = profileImage.toDictionary()
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

}
