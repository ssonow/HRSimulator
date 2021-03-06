package com.idsmanager.rp.domain;

import java.io.Serializable;


public class AuthenticateRequest implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3055017517494972870L;
	private  String version ;
    private  String challenge;
    private  String appId;
    private  String keyHandle;
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getChallenge() {
		return challenge;
	}
	public void setChallenge(String challenge) {
		this.challenge = challenge;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getKeyHandle() {
		return keyHandle;
	}
	public void setKeyHandle(String keyHandle) {
		this.keyHandle = keyHandle;
	}
    
    
}
