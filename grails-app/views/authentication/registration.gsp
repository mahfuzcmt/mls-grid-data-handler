<meta name="layout" content="public"/>

<div class="row register-form-ots">
    <div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
        <div class="card z-index-0">
            <div class="card-header text-center pt-4">
                <h5>Register</h5>
            </div>
            <div class="card-body">
                <g:form role="form text-left" controller="authentication" action="doRegistration">
                    <g:render template="/user/form"/>
                %{--            <g:submitButton name="registration" value="Registration" class="btn btn-primary"/>--}%
                    <div class="text-center">
                        <button type="submit" class="btn bg-gradient-dark w-100 my-4 mb-2">Sign up</button>
                    </div>
                    <p class="text-sm mt-3 mb-0">Already have an account? <a href="/authentication/login" class="text-dark font-weight-bolder">Sign in</a></p>
                </g:form>
            </div>
        </div>
    </div>
</div>


