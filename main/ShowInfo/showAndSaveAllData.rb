def showAndSaveAllData (capaResult, ptcResult, deviceList, midResult, media)
	showDeviceCapabilitiesInfo capaResult
	saveDeviceCapabilitiesInfo capaResult
    showProtocolInfo ptcResult, deviceList
    saveProtocolInfo ptcResult, deviceList
    showDeviceMediaInfo midResult
    saveDeviceMediaInfo midResult
    showDeviceStreamURIInfo midResult, media
    saveDeviceStreamURIInfo midResult, media
end
