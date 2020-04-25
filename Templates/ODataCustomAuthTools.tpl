<CODEGEN_FILENAME>AuthenticationTools.dbl</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>CUSTOM_JWT_ISSUER</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>CUSTOM_JWT_AUDIENCE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>CUSTOM_JWT_SECRET</REQUIRES_USERTOKEN>
;;*****************************************************************************
;;
;; Title:       AuthenticationTools.dbl
;;
;; Description: Utility class used diuring custom autentication.
;;
;; This code was originally code generated but will not be replaced by the code
;; re-generation once in existence.
;;
;;*****************************************************************************

import System
import System.Collections.Generic
import System.Text
import Microsoft.IdentityModel.Tokens
import System.Security.Claims
import System.IdentityModel.Tokens.Jwt

namespace <NAMESPACE>

    public static class AuthenticationTools

        public static method GetKey, [#]Byte
            endparams
        proc
            ;TODO: DO NOT HARD CODE THIS LIKE THIS IN PRODUCTION, AND USE SOMETHIONG MUCH MORE COMPLEX!!!!!
            mreturn Encoding.UTF8.Getbytes("<CUSTOM_JWT_SECRET>")
        endmethod

        private static ourKey, @SymmetricSecurityKey, new SymmetricSecurityKey(GetKey())

        public static method GetToken  ,string
            aUser,          string
            aTokenDuration, int
            ;;Cound add other parameters to pass in custom claims to be added to the JWT.

            record
                logical,    a40
                loglen,     i4
                tokdur,     d8

        proc

            ;;Token duration in hours
            data tokenDuration, int ,0

            if (aTokenDuration > 0) then
                tokenDuration = aTokenDuration
            else
            begin
                xcall getlog('HARMONY_TOKEN_DURATION',logical,loglen)
                if (loglen) then
                begin
                    tokdur = ^d(logical(1:loglen))
                    tokenDuration = tokdur
                    if (tokenDuration > 8767)
                        tokenDuration = 8767 ;max is 1 year
                end
                else
                    tokenDuration = 0
                if(tokenDuration < 1)
                begin
                    using aTokenDuration select
                    (-2),
                        tokenDuration = 12 ;;Login()
                    (),
                        tokenDuration = 1 ;;LoginAs()
                    endusing
                end
            end

            ;;  Create Security key  using private key above:
            ;;  not that latest version of JWT using Microsoft namespace instead of System
            ;;  Also note that ourKey length should be >256b
            ;;  so you have to make sure that your private key has a proper length

            data credentials, @Microsoft.IdentityModel.Tokens.SigningCredentials, new SigningCredentials(ourKey, SecurityAlgorithms.HmacSha256Signature, SecurityAlgorithms.Sha256Digest)
            data handler = new JwtSecurityTokenHandler()
            data ident = new ClaimsIdentity()

            ident.AddClaim(new Claim("token", %atrimtostring(aUser)))

            ;Add custom claims as necessary
            ;ident.AddClaim(new Claim("name1", "value1"))
            ;ident.AddClaim(new Claim("name2", "value2"))
            ;ident.AddClaim(new Claim("name3", "value3"))

            data theFuture, DateTime, DateTime.Now.AddHours(tokenDuration)
            data current,   DateTime, DateTime.Now.AddHours(-1)

            data betterToken = handler.CreateJwtSecurityToken("<CUSTOM_JWT_ISSUER>", "<CUSTOM_JWT_AUDIENCE>", ident, new Nullable<DateTime>(current),new Nullable<DateTime>(theFuture), new Nullable<DateTime>(DateTime.Now), credentials, ^null)

            ;;  Token to String so you can use it in your client
            data tokenString = handler.WriteToken(betterToken)

            ;data validatedToken, @SecurityToken
            ;handler.ValidateToken(tokenString, new TokenValidationParameters() { IssuerSigningKey = securityKey }, validatedToken)

            mreturn tokenString

        endmethod

    endclass

endnamespace