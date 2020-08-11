package com.mycompany.myapp.model;

public class FriendConfirm {
	private String inviter; 
	private String invitee; 
	private int status;
	public String getInviter() {
		return inviter;
	}
	public void setInviter(String inviter) {
		this.inviter = inviter;
	}
	public String getInvitee() {
		return invitee;
	}
	public void setInvitee(String invitee) {
		this.invitee = invitee;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "FriendConfirm [inviter=" + inviter + ", invitee=" + invitee + ", status=" + status + "]";
	} 
}
