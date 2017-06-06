$(document).ready(function(){
// $(function(){
  // var formModal = $('.cd-user-modal');
	var formLogin = $('#login');
	// var formSignup = formModal.find('#signup');
  var formSignup = $('#signup');
	// var formForgotPassword = formModal.find('#cd-reset-password');
	var formModalTab = $('.cd-switcher');
	var tabLogin = formModalTab.children('li').eq(0).children('a');
	var tabSignup = formModalTab.children('li').eq(1).children('a');
	// var forgotPasswordLink = formLogin.find('.cd-form-bottom-message a');
	// var backToLoginLink = formForgotPassword.find('.cd-form-bottom-message a');
	// var mainNav = $('.main-nav');

	// mainNav.on('click', function(event){
	// 	$(event.target).is(mainNav) && mainNav.children('ul').toggleClass('is-visible');
	// });

  // $('.cd-switcher').on('click', function(e){
  //   console.log("hello")
  // })

  //switch from a tab to another
	formModalTab.on('click', function(event) {
    // console.log(event)
    // console.log("hello")
		event.preventDefault();
		( $(event.target).is( tabLogin ) ) ? login_selected() : signup_selected();
	});

  function login_selected(){
    formLogin.removeClass('is-not-visible');
		formSignup.addClass('is-not-visible');
    tabLogin.addClass('selected');
    tabSignup.removeClass('selected');
    // console.log("ok")
		// formModal.addClass('is-visible');
		// $formLogin.addClass('is-visible');
		// $formSignup.removeClass('is-not-visible');
		// // formForgotPassword.removeClass('is-selected');
		// tabLogin.addClass('selected');
		// tabSignup.removeClass('selected');
	}

	function signup_selected(){
    formLogin.addClass('is-not-visible');
		formSignup.removeClass('is-not-visible');
    tabLogin.removeClass('selected');
    tabSignup.addClass('selected');
		// formModal.addClass('is-visible');
		// formLogin.removeClass('is-selected');
		// formSignup.addClass('is-selected');
		// // formForgotPassword.removeClass('is-selected');
		// tabLogin.removeClass('selected');
		// tabSignup.addClass('selected');
	}
})
