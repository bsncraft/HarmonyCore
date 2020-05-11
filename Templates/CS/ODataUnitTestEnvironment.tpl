<CODEGEN_FILENAME>UnitTestEnvironment.cs</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.6</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVICES_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_PROTOCOL</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_NAME</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_API</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_CLIENT</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_SECRET</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_SERVER</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_TEST_USER</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_TEST_PASSWORD</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataUnitTestEnvironment.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates a class that configures an environment in which unit
;//              tests can operate with a known initial data state.
;//
;// Copyright (c) 2018, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
//*****************************************************************************
//
// Title:       UnitTestEnvironment.cs
//
// Description: Configures an environment in which unit tests can operate
//              with a known initial data state.
//
//*****************************************************************************
// WARNING: GENERATED CODE!
// This file was generated by CodeGen. Avoid editing the file if possible.
// Any changes you make will be lost of the file is re-generated.
//*****************************************************************************

<IF DEFINED_ENABLE_AUTHENTICATION>
using IdentityModel.Client;
</IF DEFINED_ENABLE_AUTHENTICATION>
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.TestHost;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.IO;
using <SERVICES_NAMESPACE>;
using <MODELS_NAMESPACE>;

namespace <NAMESPACE>
{
    [TestClass]
    public class UnitTestEnvironment
    {
        public static TestServer Server;
<IF DEFINED_ENABLE_AUTHENTICATION>
        public static string AccessToken;
</IF DEFINED_ENABLE_AUTHENTICATION>

        [AssemblyInitialize]
        public static void AssemblyInitialize(TestContext context)
        {
            //Allows select to join when the keys in the file are not the same type as the keys in the code
            Dbl.Utils.SetLog("SYNSEL_NUMALPHA_KEYS", "1");

            //Configure the test environment (set logicals, create files in a known state, etc.)
            TestEnvironment.Configure();

            //Define the content root and web root folders (so we can pick up the Swagger file for API documentation)
            var wwwroot = Path.Combine(AppContext.BaseDirectory, "wwwroot");
            
            //Make sure the wwwroot folder is present
            if (!Directory.Exists(wwwroot))
                Directory.CreateDirectory(wwwroot);
            
            //Create a TestServer to host the Web API services
            Server = new TestServer(new WebHostBuilder().UseStartup<Startup>());
            
            //Fake out HTTPS
            Server.BaseAddress = new Uri("<SERVER_PROTOCOL>://<SERVER_NAME>");

<IF DEFINED_ENABLE_AUTHENTICATION>
            //Get the access token from the OAuth Server
            var disco = DiscoveryClient.GetAsync("<OAUTH_SERVER>").GetAwaiter().GetResult();

            if (disco.IsError)
            {
                throw new Exception("OAuth endpoint discovery failed. Error was: " + disco.Error);
            }
            else
            {
                var tokenClient = new TokenClient(disco.TokenEndpoint, "<OAUTH_CLIENT>", "<OAUTH_SECRET>");
                var tokenResponse = tokenClient.RequestResourceOwnerPasswordAsync("<OAUTH_TEST_USER>","<OAUTH_TEST_PASSWORD>","<OAUTH_API>").GetAwaiter().GetResult();

                if (tokenResponse.IsError)
                {
                    //Failed to get an access token from the OAuth server
                    throw new Exception(tokenResponse.Error);
                }
                else
                {
                    //Now we have an access token that we can use to call our protected API
                    AccessToken = tokenResponse.AccessToken;
                }
            }

</IF DEFINED_ENABLE_AUTHENTICATION>
        }

        [AssemblyCleanup]
        public static void AssemblyCleanup()
        {
            //Clean up the test host
            Server.Dispose();
            Server = null;

            //Delete the data files
            TestEnvironment.Cleanup();
        }
    }
}
