//
//  TTObject.h
//  iOS_TutelaNATSDK
//
//  Created by Michael Horie on 2015-02-06.
//  Copyright (c) 2015 Tutela Technologies. All rights reserved.
//

#ifndef iOS_TutelaNATSDK_TTObject_h
#define iOS_TutelaNATSDK_TTObject_h

/**
   Notification that the creation of the TTObject is complete.
 */
extern NSString *const TTObjectCompletedNotification;
/**
   A class for tracking device and connection information.
 */
@interface TTObject : NSObject

/**
   The device's connection state.
 */
@property NSString *connection;

/**
   The device's IP Address.
 */
@property NSString *ip;

/**
   The BSSID of the access point to which the device is connected. Only used with WiFi. nil otherwise.
 */
@property NSString *bssid;

/**
   The SSID of the access point to which the device is connected. Only used with WiFi. nil otherwise.
 */
@property NSString *ssid;

/**
   The cell ID of the network. nil on iOS.
 */
@property NSNumber *cid;

/**
   The local area code.  nil on iOS.
 */
@property NSNumber *lac;

/**
   The cellular Mobile Country Code, as defined by the SIM card. Only used with cellular. nil otherwise.
 */
@property NSNumber *mcc;

/**
   The cellular Mobile Network Code, as defined by the SIM card. Only used with cellular. nil otherwise.
 */
@property NSNumber *mnc;

/**
   The current service provider, as defined by the SIM card. Only used with cellular. nil otherwise.
 */
@property NSString *provider;

/**
   The cellular technology in use. Only used with cellular. nil otherwise.
 */
@property NSString *technology;

/**
   The device manufacturer.
 */
@property NSString *manufacturer;

/**
   The device model.
 */
@property NSString *model;

/**
   The device's operating system.
 */
@property NSString *os;

/**
   The altitude. nil if unavailable.
 */
@property NSNumber *altitude;

/**
   The latitude. nil if unavailable.
 */
@property NSNumber *latitude;

/**
   The longitude. nil if unavailable.
 */
@property NSNumber *longitude;

/**
   The city. nil if unavailable.
 */
@property NSString *city;

/**
   The region (e.g., province, state, prefecture). nil if unavailable.
 */
@property NSString *region;

/**
   The country. nil if unavailable.
 */
@property NSString *country;

/**
   The mail code. nil if unavailable.
 */
@property NSString *mailCode;

/**
   Create a JSON encoding of this object.
   @return
   The JSON encoding of this object.
 */
- (NSData *) jsonEncoding;
@end
#endif /* ifndef iOS_TutelaNATSDK_TTObject_h */
