//
//  AlertsEnum.swift
//  LeBaroudard
//
//  Created by Luc Derosne on 07/05/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation

// All texts for alert messages
enum errorMessage: String {
    // global  Error messages
    case networkError = "Erreur reseau"
    case unknowError = "Erreur inconnue"
    // change Error messages
    case errorChangeReception = "Taux de change non reçu"
    case errorChangeConverter = "Conversion erronée"
    case errorChangeInput = "Saisie invalide"
    //  translate Error messages
    case errorTranslateReception = "Pas de réception de traduction"
    case errorTranslation = "Pas de traduction disponible"
    case errorTranslationEmpty = " rien à traduire"
    case errorTranslationErased = "textes réinitialisés !"
    //  weather Error messages
    case errorWeatherReception = "Pas de réception météo"
    //  GpsWeather Error messages
    case errorGpsWeatherReception = "Pas de réception Gps météo"
    case errorGpsWeatherCenterLoc = "pas centrage de localisation "
    case errorGpsWeatherLocationManager = "location manager indisponible"
    case errorGpsWeatherGeocoder = " Geocoder indisponible"
    case errorGpsLocationDenied = " Localisation non autorisée"
    case errorGpsLocationRestricted = " Localisation restreinte"
}
