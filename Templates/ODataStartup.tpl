<CODEGEN_FILENAME>Startup.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.3.5</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>API_DOCS_PATH</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>API_TITLE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_API</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>OAUTH_SERVER</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_HTTPS_PORT</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataEdmBuilder.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Creates a Startup class for an OData / Web API hosting environment
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
;;*****************************************************************************
;;
;; Title:       Startup.dbl
;;
;; Type:        Class
;;
;; Description: Startup class for an OData / Web API hosting environment
;;
;;*****************************************************************************
;; WARNING
;;
;; This file was code generated. Avoid editing this file, as any changes that
;; you make will be lost of the file is re-generated.
;;
;;*****************************************************************************
;;
;; Copyright (c) 2018, Synergex International, Inc.
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;
;; * Redistributions of source code must retain the above copyright notice,
;;   this list of conditions and the following disclaimer.
;;
;; * Redistributions in binary form must reproduce the above copyright notice,
;;   this list of conditions and the following disclaimer in the documentation
;;   and/or other materials provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;; POSSIBILITY OF SUCH DAMAGE.
;;
;;*****************************************************************************
;; 
;; This environment requires the following NuGet packages:
;;
;;	Microsoft.AspNetCore.HttpsPolicy
;;	Microsoft.AspNetCore.Mvc.Core
;;	Microsoft.AspNetCore.OData
;;	Microsoft.AspNetCore.StaticFiles
;;	Microsoft.EntityFrameworkCore
;;	Microsoft.EntityFrameworkCore.Relational
;;	Microsoft.OData.Core
;;	Microsoft.OData.Edm
;;	Microsoft.Spatial
;;	Swashbuckle.AspNetCore
;;	system.text.encoding.codepages
;;

import Harmony.Core.Context
import Harmony.Core.FileIO
import Harmony.Core.Utility
import Harmony.OData
import Harmony.AspNetCore.Context
import Microsoft.AspNetCore.Builder
import Microsoft.AspNetCore.Hosting
import Microsoft.AspNetCore.Http
import Microsoft.AspNet.OData
import Microsoft.AspNet.OData.Extensions
import Microsoft.AspNet.OData.Builder
import Microsoft.AspNet.OData.Routing
import Microsoft.EntityFrameworkCore
import Microsoft.Extensions.DependencyInjection
import Microsoft.OData
import Microsoft.OData.UriParser
import Swashbuckle.AspNetCore.Swagger
import <MODELS_NAMESPACE>

namespace <NAMESPACE>

	public class Startup

		public method ConfigureServices, void
			services, @IServiceCollection 
		proc

			;;-------------------------------------------------------
			;;Load Harmony Core

			lambda AddDataObjectMappings(serviceProvider)
			begin
				data objectProvider = new DataObjectProvider(serviceProvider.GetService<IFileChannelManager>())
				<STRUCTURE_LOOP>
				objectProvider.AddDataObjectMapping<<StructureNoplural>>("<FILE_NAME>", <IF STRUCTURE_ISAM>FileOpenMode.UpdateIndexed</IF STRUCTURE_ISAM><IF STRUCTURE_RELATIVE>FileOpenMode.UpdateRelative</IF STRUCTURE_RELATIVE>)
				</STRUCTURE_LOOP>
				mreturn objectProvider
			end

			services.AddSingleton<IFileChannelManager, FileChannelManager>()
			services.AddSingleton<IDataObjectProvider>(AddDataObjectMappings)
			services.AddDbContextPool<DBContext>(ConfigureDBContext)

			;;-------------------------------------------------------
			;;Load OData and ASP.NET

			lambda AddAltKeySupport(serviceProvider)
			begin
				data model = EdmBuilder.GetEdmModel(serviceProvider)
				mreturn new AlternateKeysODataUriResolver(model) <IF NOT_DEFINED_NOCASE_URL>{ EnableCaseInsensitive = true }</IF NOT_DEFINED_NOCASE_URL>
			end

			services.AddSingleton<ODataUriResolver>(AddAltKeySupport)

			services.AddOData()

			;;-------------------------------------------------------
			;;Load our workaround for the fact that OData alternate key support is messed up right now!

			services.AddSingleton<IPerRouteContainer, HarmonyPerRouteContainer>()

			;;-------------------------------------------------------
			;;Load Swagger API documentation services

			services.AddSwaggerGen()

			services.AddMvcCore()
			&	.AddJsonFormatters()	;;For PATCH
			&	.AddApiExplorer()		;;Swagger UI

<IF DEFINED_AUTHENTICATION>
			;;-------------------------------------------------------
			;;Enable authentication and authorization

			lambda authenticationOptions(options)
			begin
				options.Authority = "<OAUTH_SERVER>"
				options.RequireHttpsMetadata = false
				options.ApiName = "<OAUTH_API>"
			end

			services.AddAuthentication("Bearer")
			&	.AddIdentityServerAuthentication(authenticationOptions)
			&	.AddAuthorization()

</IF DEFINED_AUTHENTICATION>
			;;-------------------------------------------------------
			;;Enable HTTP redirection to HTTPS

			lambda httpsConfig(options)
			begin
				options.RedirectStatusCode = StatusCodes.Status307TemporaryRedirect
				options.HttpsPort = <SERVER_HTTPS_PORT>
			end

			services.AddHttpsRedirection(httpsConfig)

<IF DEFINED_IIS_SUPPORT>
			;;-------------------------------------------------------
			;;Enable support for hosting in IIS

			lambda iisOptions(options)
			begin
				options.ForwardClientCertificate = false
			end

			services.Configure<IISOptions>(iisOptions)
			
</IF DEFINED_IIS_SUPPORT>
<IF DEFINED_ENABLE_CORS>
			;;-------------------------------------------------------
			;;Add "Cross Origin Resource Sharing" (CORS) support

			services.AddCors()

</IF DEFINED_ENABLE_CORS>
		endmethod

		private method ConfigureDBContext, void
			required in sp, @IServiceProvider
			required in opts, @DbContextOptionsBuilder
		proc
			HarmonyDbContextOptionsExtensions.UseHarmonyDatabase(opts, sp.GetService<IDataObjectProvider>())
		endmethod

		public method Configure, void
			required in app, @IApplicationBuilder
			required in env, @IHostingEnvironment
		proc
			;;-------------------------------------------------------
			;;Configure development and production specific components

			if (env.IsDevelopment()) then
			begin
				app.UseDeveloperExceptionPage()
				app.UseLogging(DebugLogSession.Logging)
			end
			else
			begin
				;;Enable HTTP Strict Transport Security Protocol (HSTS)
				;
				;You need to research this and know what you are doing with this. Here's a starting point:
				;https://docs.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-2.1&tabs=visual-studio
				;
				;app.UseHsts()
			end

			;;-------------------------------------------------------
			;;Enable HTTP redirection to HTTPS

			app.UseHttpsRedirection()

<IF DEFINED_AUTHENTICATION>
			;;-------------------------------------------------------
			;;Enable the authentication middleware

			app.UseAuthentication()

</IF DEFINED_AUTHENTICATION>
			;;-------------------------------------------------------
			;;Configure the MVC & OData environments

			lambda mvcBuilder(builder)
			begin
				data model = EdmBuilder.GetEdmModel(app.ApplicationServices)

				lambda UriResolver(s)
				begin
					data result = app.ApplicationServices.GetRequiredService<ODataUriResolver>()
					mreturn result
				end

				lambda EnableDI(containerBuilder)
				begin
					containerBuilder.AddService<Microsoft.OData.UriParser.ODataUriResolver>( Microsoft.OData.ServiceLifetime.Singleton, UriResolver)
					nop
				end

				builder.EnableDependencyInjection(EnableDI)

				;;Enable optional OData features
				builder.Select().Expand().Filter().OrderBy().MaxTop(100).Count()

				;;Configure the default OData route
				builder.MapODataServiceRoute("odata", "odata", model)
			end

			app.UseMvc(mvcBuilder)

<IF DEFINED_ENABLE_CORS>
			;;-------------------------------------------------------
			;;Add "Cross Origin Resource Sharing" (CORS) support

			lambda corsOptions(builder)
			begin
				builder.AllowAnyOrigin()
				&	.AllowAnyMethod()
				&	.AllowAnyHeader()
			end

			app.UseCors(corsOptions)

</IF DEFINED_ENABLE_CORS>
			;;-------------------------------------------------------
			;;Configure and enable SwaggerUI

			lambda configureSwaggerUi(config)
			begin
				config.SwaggerEndpoint("/SwaggerFile.json", "<API_TITLE>")
				config.RoutePrefix = "<API_DOCS_PATH>"
				config.DocumentTitle = "<API_TITLE>"
			end

			app.UseDefaultFiles()
			app.UseStaticFiles()
			app.UseSwagger()
			app.UseSwaggerUI(configureSwaggerUi)

		endmethod

	endclass

endnamespace
