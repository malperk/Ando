//
//	UDLink.swift
//
//	Create by Alper KARATAS on 24/5/2017
//	Copyright © 2017 Fugo. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct UDLink{

	var download : String!
	var downloadLocation : String!
	var html : String!
	var me : String!
	var followers : String!
	var following : String!
	var likes : String!
	var photos : String!
	var portfolio : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		download = dictionary["download"] as? String
		downloadLocation = dictionary["download_location"] as? String
		html = dictionary["html"] as? String
		me = dictionary["self"] as? String
		followers = dictionary["followers"] as? String
		following = dictionary["following"] as? String
		likes = dictionary["likes"] as? String
		photos = dictionary["photos"] as? String
		portfolio = dictionary["portfolio"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if download != nil{
			dictionary["download"] = download
		}
		if downloadLocation != nil{
			dictionary["download_location"] = downloadLocation
		}
		if html != nil{
			dictionary["html"] = html
		}
		if me != nil{
			dictionary["self"] = me
		}
		if followers != nil{
			dictionary["followers"] = followers
		}
		if following != nil{
			dictionary["following"] = following
		}
		if likes != nil{
			dictionary["likes"] = likes
		}
		if photos != nil{
			dictionary["photos"] = photos
		}
		if portfolio != nil{
			dictionary["portfolio"] = portfolio
		}
		return dictionary
	}

}
