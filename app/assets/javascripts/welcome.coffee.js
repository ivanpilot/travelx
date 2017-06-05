jQuery(document).ready(function($){

  var formModal = $('.cd-user-modal');
	var formLogin = formModal.find('#cd-login');
	var formSignup = formModal.find('#cd-signup');
	var formForgotPassword = formModal.find('#cd-reset-password');
	var formModalTab = $('.cd-switcher');
	var tabLogin = formModalTab.children('li').eq(0).children('a');
	var tabSignup = formModalTab.children('li').eq(1).children('a');
	var forgotPasswordLink = formLogin.find('.cd-form-bottom-message a');
	var backToLoginLink = formForgotPassword.find('.cd-form-bottom-message a');
	var mainNav = $('.main-nav');

	mainNav.on('click', function(event){
		$(event.target).is(mainNav) && mainNav.children('ul').toggleClass('is-visible');
	});

function login_selected(){

		formModal.addClass('is-visible');
		formLogin.addClass('is-selected');
		formSignup.removeClass('is-selected');
		formForgotPassword.removeClass('is-selected');
		tabLogin.addClass('selected');
		tabSignup.removeClass('selected');
	}

	function signup_selected(){

		formModal.addClass('is-visible');
		formLogin.removeClass('is-selected');
		formSignup.addClass('is-selected');
		formForgotPassword.removeClass('is-selected');
		tabLogin.removeClass('selected');
		tabSignup.addClass('selected');
	}
}
