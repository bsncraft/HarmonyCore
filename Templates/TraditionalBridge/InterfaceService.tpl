<CODEGEN_FILENAME><INTERFACE_NAME>Service.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.4</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       InterfaceService.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Creates a service class that exposes former xfServerPlus methods
;//              in an interface via Harmony Core Traditional Bridge
;//
;// Copyright (c) 2019, Synergex International, Inc. All rights reserved.
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
;; Title:       <INTERFACE_NAME>Service.dbl
;;
;; Description: Service to expose methods that are part of the former
;;              xfServerPlus / xfNetLink "<INTERFACE_NAME>" interface.
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import Harmony.Core
import Harmony.Core.Context
import Harmony.Core.Interface
import Harmony.Core.EF.Extensions
import Harmony.OData
import Harmony.OData.Adapter
import System.Threading.Tasks
import System
import System.Collections.Generic
import System.Text
import Microsoft.AspNetCore.Mvc
import Microsoft.AspNet.OData
import Microsoft.AspNetCore.Authorization
import Newtonsoft.Json.Linq
import System.Linq

import <NAMESPACE>
import <MODELS_NAMESPACE>

namespace <NAMESPACE>

    public partial class <INTERFACE_NAME>Service extends DynamicCallProvider

        ;;; <summary>
        ;;; Constructor
        ;;; </summary>
        public method <INTERFACE_NAME>Service
            connection, @IDynamicCallConnection
            endparams
            parent(connection)
        proc
            
        endmethod
<METHOD_LOOP>

        ;;; <summary>
        ;;; <IF COMMENT><METHOD_COMMENT><ELSE>No description found in method catalog</IF COMMENT>
        ;;; </summary>
        public async method <METHOD_NAME>, @Task<IF RETURNS_DATA><<METHOD_NAME>_Response></IF RETURNS_DATA>
  <IF IN_OR_INOUT>
            required in args, @<METHOD_NAME>_Request
  </IF IN_OR_INOUT>
        proc
  <IF RETURNS_DATA>
            ;;Prepare the response object
            data response = new <METHOD_NAME>_Response()

  </IF RETURNS_DATA>
            ;;Make the JSON-RPC call the traditional Synergy routine
            data resultTuple = await CallMethod("<METHOD_NAME>"
    <PARAMETER_LOOP>
            &   ,<IF OPTIONAL>ArgumentHelper.MayBeOptional(</IF OPTIONAL><IF IN_OR_INOUT>args.<PARAMETER_NAME><ELSE>response.<PARAMETER_NAME></IF IN_OR_INOUT><IF OPTIONAL>)</IF OPTIONAL>
    </PARAMETER_LOOP>
            &   )
  <IF RETURNS_DATA>

            ;;Get the returned information
            data returnToken = (@JToken)(resultTuple.Item1)
    <IF FUNCTION>

            ;;Set the return value in the return data
            response.ReturnValue = returnToken.ToObject<<HARMONYCORE_BRIDGE_RETURN_TYPE>>()
    </IF FUNCTION>
    <IF OUT_OR_INOUT>

            ;;Set returned values for OUT or INOUT parameters
            data resultList, @List<Object>, resultTuple.Item2.ToList()
    <PARAMETER_LOOP>
      <IF OUT_OR_INOUT>
        <IF REQUIRED>
            response.<PARAMETER_NAME> = (<HARMONYCORE_BRIDGE_PARAMETER_TYPE>)resultList[<PARAMETER_NUMBER> - 1]
        <ELSE>
            response.<PARAMETER_NAME> = ^as(resultList[<PARAMETER_NUMBER> - 1],<HARMONYCORE_BRIDGE_PARAMETER_TYPE>)
        </IF REQUIRED>
      </IF OUT_OR_INOUT>
    </PARAMETER_LOOP>
  </IF OUT_OR_INOUT>

            ;;Return the response
            mreturn response

  </IF RETURNS_DATA>
        endmethod
</METHOD_LOOP>

    endclass

endnamespace
