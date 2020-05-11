<CODEGEN_FILENAME><StructureNoplural>Tests.cs</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.6</REQUIRES_CODEGEN_VERSION>
<REQUIRES_OPTION>TF</REQUIRES_OPTION>
<CODEGEN_FOLDER>UnitTests</CODEGEN_FOLDER>
<REQUIRES_USERTOKEN>CLIENT_MODELS_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVICES_NAMESPACE</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataUnitTests.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates unit tests for Web API / OData controllers in a
;//              Harmony Core environment.
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
// Title:       <StructureNoplural>Tests.cs
//
// Description: Unit tests for the operations defined in <StructurePlural>Controller.
//
//*****************************************************************************
// WARNING: GENERATED CODE!
// This file was generated by CodeGen. Avoid editing the file if possible.
// Any changes you make will be lost of the file is re-generated.
//*****************************************************************************

using Microsoft.AspNetCore.JsonPatch;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net;
using <SERVICES_NAMESPACE>;
using <CLIENT_MODELS_NAMESPACE>;

namespace <NAMESPACE>
{
    [TestClass]
    public partial class <StructureNoplural>Tests
    {
        //------------------------------------------------------------
        //Get all <StructurePlural>

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Read All")]
        public void Get<StructurePlural>()
        {
            using var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>
            using var response = client.GetAsync("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>").Result;
            var result = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
            var <structurePlural> = JsonConvert.DeserializeObject<OData<StructurePlural>>(result);
        }

<IF DEFINED_ENABLE_RELATIONS>
  <IF STRUCTURE_RELATIONS>
    <RELATION_LOOP_RESTRICTED>
        //------------------------------------------------------------
        //Get all <StructurePlural> and expand relation <HARMONYCORE_RELATION_NAME>

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Read All")]
        <IF MANY_TO_ONE_TO_MANY>
        public void Get<StructurePlural>_Expand_<HARMONYCORE_RELATION_NAME>()
        {
            var uri = "/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>?$expand=<HARMONYCORE_RELATION_NAME>";
        </IF MANY_TO_ONE_TO_MANY>
        <IF ONE_TO_ONE>
        public void Get<StructurePlural>_Expand_<HARMONYCORE_RELATION_NAME>()
        {
            var uri = "/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>?$expand=<HARMONYCORE_RELATION_NAME>";
        </IF ONE_TO_ONE>
        <IF ONE_TO_MANY_TO_ONE>
        public void Get<StructurePlural>_Expand_<HARMONYCORE_RELATION_NAME>()
        {
            var uri = "/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>?$expand=<HARMONYCORE_RELATION_NAME>";
        </IF ONE_TO_MANY_TO_ONE>
        <IF ONE_TO_MANY>
        public void Get<StructurePlural>_Expand_<HARMONYCORE_RELATION_NAME>()
        {
            var uri = "/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>?$expand=<HARMONYCORE_RELATION_NAME>";
        </IF ONE_TO_MANY>
            using var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>
            using var response = client.GetAsync(uri).Result;
            var result = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
        }

    </RELATION_LOOP_RESTRICTED>
        //------------------------------------------------------------
        //Get all <StructurePlural> and expand all relations

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Read All")]
        public void Get<StructurePlural>_Expand_All()
        {
            var uri = "/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>?$expand=<RELATION_LOOP_RESTRICTED><IF MANY_TO_ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF MANY_TO_ONE_TO_MANY><IF ONE_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_ONE><IF ONE_TO_MANY_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY_TO_ONE><IF ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY><,></RELATION_LOOP_RESTRICTED>";
            using var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>
            using var response = client.GetAsync(uri).Result;
            var result = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
        }
        
  </IF STRUCTURE_RELATIONS>
</IF DEFINED_ENABLE_RELATIONS>
<IF STRUCTURE_ISAM>
        //------------------------------------------------------------
        //Get a single <StructureNoplural> by primary key

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Read by Primary Key")]
        public void Get<StructureNoplural>()
        {
            var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>
            var request = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Get<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>);
            var response = client.GetAsync(request).Result;
            var result = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
            var <structureNoplural> = JsonConvert.DeserializeObject<OData<StructureNoplural>>(result);
        }

</IF STRUCTURE_ISAM>
<IF DEFINED_ENABLE_RELATIONS>
  <IF STRUCTURE_RELATIONS>
    <RELATION_LOOP_RESTRICTED>
        //------------------------------------------------------------
        //Get a single <StructureNoplural> by primary key and expand relation <IF MANY_TO_ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF MANY_TO_ONE_TO_MANY><IF ONE_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_ONE><IF ONE_TO_MANY_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY_TO_ONE><IF ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY>

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Read by Primary Key")]
        public void Get<StructureNoplural>_Expand_<IF MANY_TO_ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF MANY_TO_ONE_TO_MANY><IF ONE_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_ONE><IF ONE_TO_MANY_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY_TO_ONE><IF ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY>()
        {
            var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>
            var request = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP></PRIMARY_KEY>)?$expand=<IF MANY_TO_ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF MANY_TO_ONE_TO_MANY><IF ONE_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_ONE><IF ONE_TO_MANY_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY_TO_ONE><IF ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY>","",<PRIMARY_KEY><SEGMENT_LOOP>TestConstants.Get<StructureNoplural>_Expand_<IF MANY_TO_ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF MANY_TO_ONE_TO_MANY><IF ONE_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_ONE><IF ONE_TO_MANY_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY_TO_ONE><IF ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>);
            var response = client.GetAsync(request).Result;
            var result = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
            var <structureNoplural> = JsonConvert.DeserializeObject<OData<StructureNoplural>>(result);
        }

    </RELATION_LOOP_RESTRICTED>
        //------------------------------------------------------------
        //Get a single <StructureNoplural> by primary key and expand all relations

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Read by Primary Key")]
        public void Get<StructureNoplural>_Expand_All()
        {
            var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>
            var request = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP></PRIMARY_KEY>)?$expand=<RELATION_LOOP_RESTRICTED><IF MANY_TO_ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF MANY_TO_ONE_TO_MANY><IF ONE_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_ONE><IF ONE_TO_MANY_TO_ONE><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY_TO_ONE><IF ONE_TO_MANY><HARMONYCORE_RELATION_NAME></IF ONE_TO_MANY><,></RELATION_LOOP_RESTRICTED>","",<PRIMARY_KEY><SEGMENT_LOOP>TestConstants.Get<StructureNoplural>_Expand_All_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>);
            var response = client.GetAsync(request).Result;
            var result = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
            var <structureNoplural> = JsonConvert.DeserializeObject<OData<StructureNoplural>>(result);
        }

  </IF STRUCTURE_RELATIONS>
</IF DEFINED_ENABLE_RELATIONS>
<IF STRUCTURE_ISAM>
<IF DEFINED_ENABLE_ALTERNATE_KEYS>
<ALTERNATE_KEY_LOOP>
        //------------------------------------------------------------
        //Get a single <StructureNoplural> by alternate key <KEY_NUMBER> (<KeyName>)

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Read by Alternate Key")]
        public void Get<StructureNoplural>_ByAltKey_<KeyName>()
        {
            var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>
            var request = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP>)", "", <SEGMENT_LOOP>TestConstants.Get<StructureNoplural>_ByAltKey_<KeyName>_<SegmentName><IF DATE>.ToString("yyyy-MM-dd")</IF DATE><,></SEGMENT_LOOP>);
            var response = client.GetAsync(request).Result;
            var result = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
<IF DUPLICATES>
            var <structurePlural> = JsonConvert.DeserializeObject<OData<StructurePlural>>(result);
<ELSE>
            var <structureNoplural> = JsonConvert.DeserializeObject<OData<StructureNoplural>>(result);
</IF DUPLICATES>
        }

</ALTERNATE_KEY_LOOP>
</IF DEFINED_ENABLE_ALTERNATE_KEYS>
</IF STRUCTURE_ISAM>
;//        //------------------------------------------------------------
;//        //Create a new <StructureNoplural> (auto assign key)
;//
;//        [TestMethod]
;//        [TestCategory("<StructureNoplural> Tests - Create, Update & Delete")]
;//        public void Create<StructureNoplural>()
;//        {
;//            using var client = UnitTestEnvironment.Server.CreateClient();
;//            <IF DEFINED_ENABLE_AUTHENTICATION>
;//            client.SetBearerToken(UnitTestEnvironment.AccessToken);
;//            </IF DEFINED_ENABLE_AUTHENTICATION>
;//            using var requestBody = new StringContent("");
;//            using var response = client.PostAsync("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>", requestBody).Result;
;//            var result = response.Content.ReadAsStringAsync().Result;
;//            response.EnsureSuccessStatusCode();
;//        }
;//
<IF DEFINED_ENABLE_PUT>
<IF DEFINED_ENABLE_PATCH>
<IF DEFINED_ENABLE_DELETE>
        //------------------------------------------------------------
        //Create new <StructureNoplural> (client specified key)

        [TestMethod]
        [TestCategory("<StructureNoplural> Tests - Create, Update & Delete")]
        public void Update<StructureNoplural>()
        {
            using var client = UnitTestEnvironment.Server.CreateClient();
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.SetBearerToken(UnitTestEnvironment.AccessToken);
            </IF DEFINED_ENABLE_AUTHENTICATION>

            //Get one <structureNoplural> from the file
            var getRequest = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Get<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>);
            var getResponse = client.GetAsync(getRequest).Result;
            var getResult = getResponse.Content.ReadAsStringAsync().Result;

            //Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode();

            //Deserialize the JSON into a <StructureNoplural> object
            var do<StructureNoplural> = JsonConvert.DeserializeObject<<StructureNoplural>>(getResult);

            <PRIMARY_KEY>
            <SEGMENT_LOOP>
            do<StructureNoplural>.<FieldSqlName> = TestConstants.Update<StructureNoplural>_<SegmentName>;
            </SEGMENT_LOOP>
            </PRIMARY_KEY>

            //TODO: Also need to ensure any nodups alternate keys get unique values

            //Create new item
            var requestBody = new StringContent(JsonConvert.SerializeObject(do<StructureNoplural>),System.Text.Encoding.UTF8, "application/json");
            var request = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Update<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>);
            var response = client.PutAsync(request, requestBody).Result;

            //Check that we got a successful response from the web service
            response.EnsureSuccessStatusCode();

            //Get the inserted record
            getResponse = client.GetAsync(request).Result;
            getResult = getResponse.Content.ReadAsStringAsync().Result;

            //Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode();

            //Deserialize the JSON into a <StructureNoplural> object
            do<StructureNoplural> = JsonConvert.DeserializeObject<<StructureNoplural>>(getResult);

            //Change the first non key field to test full update
            <COUNTER_1_RESET>
            <FIELD_LOOP>
            <IF NOTKEYSEGMENT>
            <IF USED_IN_RELATION>
            <ELSE>
            <COUNTER_1_INCREMENT>
            <IF COUNTER_1_EQ_1>
            <IF ALPHA>
            do<StructureNoplural>.<FieldSqlName> = "Y";
            <ELSE>
            do<StructureNoplural>.<FieldSqlName> = 8;
            </IF ALPHA>
            </IF COUNTER_1_EQ_1>
            </IF USED_IN_RELATION>
            </IF NOTKEYSEGMENT>
            </FIELD_LOOP>

            //Update full item
            requestBody = new StringContent(JsonConvert.SerializeObject(do<StructureNoplural>),System.Text.Encoding.UTF8, "application/json");
            request = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Update<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>);
            response = client.PutAsync(request, requestBody).Result;

            //Check that we got a successful response from the web service
            response.EnsureSuccessStatusCode();

            //Get the inserted record
            getResponse = client.GetAsync(request).Result;
            getResult = getResponse.Content.ReadAsStringAsync().Result;

            //Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode();

            //Deserialize the JSON into a <StructureNoplural> object
            do<StructureNoplural> = JsonConvert.DeserializeObject<<StructureNoplural>>(getResult);

            <COUNTER_1_RESET>
            <FIELD_LOOP>
            <IF NOTKEYSEGMENT>
            <IF USED_IN_RELATION>
            <ELSE>
            <COUNTER_1_INCREMENT>
            <IF COUNTER_1_EQ_1>
            <IF ALPHA>
            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, "Y");
            <ELSE>
            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, 8);
            </IF ALPHA>
            </IF COUNTER_1_EQ_1>
            </IF USED_IN_RELATION>
            </IF NOTKEYSEGMENT>
            </FIELD_LOOP>


            //Update one non-existant property in the customer
            var badPatchDoc = new JsonPatchDocument();
            badPatchDoc.Replace("xyzzy", "Z");

            //Serialize the bad patch to JSON
            var badSerializedPatch = JsonConvert.SerializeObject(badPatchDoc);

            //Apply the bad patch
            using var badPatchRequestBody = new StringContent(badSerializedPatch,System.Text.Encoding.UTF8, "application/json-patch+json");
            using var badPatchResponse = client.PatchAsync(request, badPatchRequestBody).Result;
            //Check that we got a failure response from the web service
            Assert.AreEqual(badPatchResponse.StatusCode, HttpStatusCode.BadRequest);

            //Update one property in the <structureNoplural>
            var patchDoc = new JsonPatchDocument();
            <COUNTER_1_RESET>
            <FIELD_LOOP>
            <IF NOTKEYSEGMENT>
            <IF USED_IN_RELATION>
            <ELSE>
            <COUNTER_1_INCREMENT>
            <IF COUNTER_1_EQ_1>
            <IF ALPHA>
            patchDoc.Replace("<FieldSqlName>", "Z");
            <ELSE>
            patchDoc.Replace("<FieldSqlName>", "9");
            </IF ALPHA>
            </IF COUNTER_1_EQ_1>
            </IF USED_IN_RELATION>
            </IF NOTKEYSEGMENT>
            </FIELD_LOOP>

            //Serialize the patch to JSON
            var serializedPatch = JsonConvert.SerializeObject(patchDoc);

            //Apply the patch
            using var patchRequestBody = new StringContent(serializedPatch,System.Text.Encoding.UTF8, "application/json-patch+json");
            using var patchResponse = client.PatchAsync(request, patchRequestBody).Result;

            //Check that we got a successful response from the web service
            patchResponse.EnsureSuccessStatusCode();

            //Get the updated <structureNoplural> record
            getResponse = client.GetAsync(request).Result;
            getResult = getResponse.Content.ReadAsStringAsync().Result;

            //Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode();

            //Deserialize the JSON into a <StructureNoplural> object
            do<StructureNoplural> = JsonConvert.DeserializeObject<<StructureNoplural>>(getResult);

            //Verify that the property was changed
            <COUNTER_1_RESET>
            <FIELD_LOOP>
            <IF NOTKEYSEGMENT>
            <IF USED_IN_RELATION>
            <ELSE>
            <COUNTER_1_INCREMENT>
            <IF COUNTER_1_EQ_1>
            <IF ALPHA>
            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, "Z");
            <ELSE>
            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, 9);
            </IF ALPHA>
            </IF COUNTER_1_EQ_1>
            </IF USED_IN_RELATION>
            </IF NOTKEYSEGMENT>
            </FIELD_LOOP>

            //Delete It
            using var deleteResponse = client.DeleteAsync(request).Result;

            //Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode();

            //Attempt to get the deleted record
            getResponse = client.GetAsync(request).Result;

            //Check we got a fail state from the web service
            Assert.AreEqual(getResponse.IsSuccessStatusCode, false);

        }

</IF DEFINED_ENABLE_DELETE>
</IF DEFINED_ENABLE_PATCH>
</IF DEFINED_ENABLE_PUT>
;//<PRIMARY_KEY>
;//<IF MULTIPLE_SEGMENTS>
;//        //------------------------------------------------------------
;//        //Get multiple <StructureNoplural> by partial primary key
;//
;//        [TestMethod]
;//        [TestCategory("<StructureNoplural> Tests - Read by Primary Key")]
;//        public void Get<StructureNoplural>_ByPartialPrimaryKey()
;//        {
;//            var client = UnitTestEnvironment.Server.CreateClient();
;//            <IF DEFINED_ENABLE_AUTHENTICATION>
;//            client.SetBearerToken(UnitTestEnvironment.AccessToken);
;//            </IF DEFINED_ENABLE_AUTHENTICATION>
;//            var request = String.Format("/odata<IF DEFINED_ENABLE_API_VERSIONING>/v<API_VERSION></IF DEFINED_ENABLE_API_VERSIONING>/<StructurePlural>(<SEGMENT_LOOP_FILTER><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><,></SEGMENT_LOOP_FILTER>)","",<SEGMENT_LOOP_FILTER>TestConstants.Get<StructureNoplural>_ByPartialPrimaryKey_<SegmentName><,></SEGMENT_LOOPFILTER>);
;//            var response = client.GetAsync(request).Result;
;//            var result = response.Content.ReadAsStringAsync().Result;
;//            response.EnsureSuccessStatusCode();
;//            var <structureNoplural> = JsonConvert.DeserializeObject<OData<StructureNoplural>>(result);
;//        }
;//
;//</IF MULTIPLE_SEGMENTS>
;//</PRIMARY_KEY>
    }

}
