<CODEGEN_FILENAME>SelfHostEnvironment.cs</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.6</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>DATA_FOLDER</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVICES_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataSelfHostEnvironment.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates an environment setup class for a self host program
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
// Title:       SelfHostEnvironment.cs
//
// Description: Environment setup class for a Harmony Core self host program
//
//*****************************************************************************
// WARNING: GENERATED CODE!
// This file was generated by CodeGen. Avoid editing the file if possible.
// Any changes you make will be lost of the file is re-generated.
//*****************************************************************************

using Harmony.Core.FileIO;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Synergex.SynergyDE;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using <SERVICES_NAMESPACE>;
using <MODELS_NAMESPACE>;

namespace <NAMESPACE>
{
    public static partial class SelfHostEnvironment
    {
        //Declare the InitializeCustom partial method
        //This method can be implemented in a partial class to provide custom code to initialize the self hosting environment
        static partial void InitializeCustom();

        public static void Initialize()
        {
            //Allows select to join when the keys in the file are not the same type as the keys in the code
            Dbl.Utils.SetLog("SYNSEL_NUMALPHA_KEYS", "1");

            //Configure the test environment (set logicals, create files in a known state, etc.)
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            setLogicals();
<IF DEFINED_ENABLE_CREATE_TEST_FILES>
            deleteFiles();
            createFiles();

</IF DEFINED_ENABLE_CREATE_TEST_FILES>
            //If we have an InitializeCustom method, call it
            InitializeCustom();

        }

        //Declare the CleanupCustom partial method
        //This method can be implemented in a partial class to provide custom code to cleanup the self hosting environment before close
        static partial void CleanupCustom();

        public static void Cleanup()
        {
<IF DEFINED_ENABLE_CREATE_TEST_FILES>
            //Delete the data files
            deleteFiles();

</IF DEFINED_ENABLE_CREATE_TEST_FILES>
            //If we have a CleanupCustom method, call it
            CleanupCustom();
        }

        //Declare the SetLogicalsCustom partial method
        //This method can be implemented in a partial class to provide custom code to define logical names
        static partial void SetLogicalsCustom(List<string> logicals);

        private static void setLogicals()
        {
            var sampleDataFolder = findRelativeFolderForAssembly("SampleData");
            Startup.LogicalNames = new List<string>();
            var fileSpec = string.Empty;
            <STRUCTURE_LOOP>

            fileSpec = "<FILE_NAME>";
            if (fileSpec.Contains(":"))
            {
                var logical = fileSpec.Split(":")[0].ToUpper();
                if (!Startup.LogicalNames.Contains(logical))
                {
                    Startup.LogicalNames.Add(logical);
                }
            }
            else if (!fileSpec.Contains("."))
            {
                if (!Startup.LogicalNames.Contains(fileSpec))
                {
                    Startup.LogicalNames.Add(fileSpec);
                }
            }
            </STRUCTURE_LOOP>

            //If we have a SetLogicalsCustom method, call it
            SetLogicalsCustom(Startup.LogicalNames);

<IF NOT_DEFINED_DO_NOT_SET_FILE_LOGICALS>
            //Now we'll check each logical. If it already has a value we'll do nothing, otherwise
            //we'll set the logical to point to the local folder whose name is identified by the
            //user-defined token DATA_FOLDER
            foreach (var logical in from logical in Startup.LogicalNames
                let translation = Environment.GetEnvironmentVariable(logical)
                where translation == null
                select logical)
            {
                Dbl.Utils.SetLog(logical, sampleDataFolder);
            }

</IF NOT_DEFINED_DO_NOT_SET_FILE_LOGICALS>
        }

<IF DEFINED_ENABLE_CREATE_TEST_FILES>
        private static void createFiles()
        {
            var chout = 0;
            string dataFile;
            string xdlFile;
            <STRUCTURE_LOOP>
            <IF STRUCTURE_ISAM>
            var <structurePlural> = load<StructurePlural>();
            </IF STRUCTURE_ISAM>
            </STRUCTURE_LOOP>

            <STRUCTURE_LOOP>
            //Create and load the <structurePlural> file

            dataFile = "<FILE_NAME>";
<IF STRUCTURE_ISAM>
            xdlFile = "@" + dataFile.ToLower().Replace(".ism",".xdl");
            Dbl.Utils.OpenOutputIndexed(ref chout, dataFile, xdlFile);            
            foreach (var <structureNoplural> in <structurePlural>)
                Dbl.Utils.Store(chout, <structureNoplural>.SynergyRecord);
            Dbl.Utils.Close(chout);

</IF STRUCTURE_ISAM>
<IF STRUCTURE_RELATIVE>
            var sourceFile = dataFile.ToLower().Replace(".ddf",".txt");
            File.Copy(sourceFile, dataFile);

</IF STRUCTURE_RELATIVE>
            </STRUCTURE_LOOP>
        }

        private static void deleteFiles()
        {
            <STRUCTURE_LOOP>
            //Delete the <structurePlural> file
            try
            {
                Dbl.Utils.Delete("<FILE_NAME>");
            }
            catch (NoFileFoundException e)
            {
            }

            </STRUCTURE_LOOP>
        }

        <STRUCTURE_LOOP>
        <IF STRUCTURE_ISAM>
        public static List<<StructureNoplural>> load<StructurePlural>()
        {
            const string dataFile = "<FILE_NAME>";
            var textFile = dataFile.ToLower().Replace(".ism", ".txt");
            var <structurePlural> = new List<<StructureNoplural>>();
            using var channelManager = new FileChannelManager();
            using var fileIO = new IsamDataObjectIO<<StructureNoplural>>(channelManager, textFile, FileOpenMode.InputSequential);
            if (fileIO.ReadFirstRecord(out <StructureNoplural> first<StructureNoplural>) != FileAccessResults.Success)
            {
                return <structurePlural>;
            }
            <structurePlural>.Add(first<StructureNoplural>);
            while (fileIO.ReadNextRecord(out <StructureNoplural> next<StructureNoplural>) == FileAccessResults.Success)
            {
                <structurePlural>.Add(next<StructureNoplural>);                
            }

            return <structurePlural>;
        }

        </IF STRUCTURE_ISAM>
        </STRUCTURE_LOOP>
</IF DEFINED_ENABLE_CREATE_TEST_FILES>
        private static string findRelativeFolderForAssembly(string folderName)
        {
            var assemblyLocation = typeof(SelfHostEnvironment).Assembly.Location;
            var currentFolder = Path.GetDirectoryName(assemblyLocation);
            var rootPath = Path.GetPathRoot(currentFolder);
            while (currentFolder != null && currentFolder != rootPath)
            {
                if (Directory.Exists(Path.Combine(currentFolder, folderName)))
                    return Path.Combine(currentFolder, folderName);

                currentFolder = Path.GetFullPath(currentFolder + "..\\");
            }

            return null;
        }
    }
}