<CODEGEN_FILENAME>TestEnvironment.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.3.12</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>DATA_FOLDER</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataTestEnvironment.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates utilities for configuting a hosting environment.
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
;; Title:       TestEnvironment.dbl
;;
;; Description: Utilities for configuting a hosting environment.
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import System.Collections.Generic
import System.IO
import System.Text
import <MODELS_NAMESPACE>
<IF DEFINED_ENABLE_CREATE_TEST_FILES>
import <NAMESPACE>.DataGenerators
</IF DEFINED_ENABLE_CREATE_TEST_FILES>

.array 0

namespace <NAMESPACE>

    public static class TestEnvironment

        public static method Configure, void
        proc
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance)
            setLogicals()
<IF DEFINED_ENABLE_CREATE_TEST_FILES>
            deleteFiles()
            createFiles()
</IF DEFINED_ENABLE_CREATE_TEST_FILES>
        endmethod

        public static method Cleanup, void
        proc
<IF DEFINED_ENABLE_CREATE_TEST_FILES>
            deleteFiles()
</IF DEFINED_ENABLE_CREATE_TEST_FILES>
        endmethod

        private static method setLogicals, void
        proc
            data sampleDataFolder = findRelativeFolderForAssembly("<DATA_FOLDER>")
            data logicals = new List<string>()
            data logical = String.Empty
            data fileSpec = String.Empty
            <STRUCTURE_LOOP>

            fileSpec = "<FILE_NAME>"
            if (fileSpec.Contains(":"))
            begin
                logical = fileSpec.Split(":")[0].ToUpper()
                if (!logicals.Contains(logical))
                    logicals.Add(logical)
            end
            </STRUCTURE_LOOP>

            foreach logical in logicals
            begin
                data sts, int
                xcall setlog(logical,sampleDataFolder,sts)
            end

        endmethod

<IF DEFINED_ENABLE_CREATE_TEST_FILES>
        private static method createFiles, void
        proc
            data chout, int
            data dataFile, string
            data xdlFile, string

<STRUCTURE_LOOP>
  <IF STRUCTURE_ISAM>
            data <structurePlural> = <StructureNoplural>Loader.LoadFromFile()
  </IF STRUCTURE_ISAM>
</STRUCTURE_LOOP>

<STRUCTURE_LOOP>
            ;;Create and load the <structurePlural> file

            dataFile = "<FILE_NAME>"
  <IF STRUCTURE_ISAM>
            xdlFile = "@" + dataFile.ToLower().Replace(".ism",".xdl")

            data <structureNoplural>, @<StructureNoplural>
            open(chout=0,o:i,dataFile,FDL:xdlFile)
            foreach <structureNoplural> in <structurePlural>
                store(chout,<structureNoplural>.SynergyRecord)
            close chout

  </IF STRUCTURE_ISAM>
  <IF STRUCTURE_RELATIVE>
            data sourceFile = dataFile.ToLower().Replace(".ddf",".txt")
            xcall copy(sourceFile,dataFile,1)

  </IF STRUCTURE_RELATIVE>
</STRUCTURE_LOOP>
        endmethod

        private static method deleteFiles, void
        proc
            <STRUCTURE_LOOP>
            ;;Delete the <structurePlural> file
            try
            begin
                xcall delet("<FILE_NAME>")
            end
            catch (e, @NoFileFoundException)
            begin
                nop
            end
            endtry

            </STRUCTURE_LOOP>
        endmethod

</IF DEFINED_ENABLE_CREATE_TEST_FILES>
        private static method findRelativeFolderForAssembly, string
            folderName, string
        proc
            data assemblyLocation = ^typeof(TestEnvironment).Assembly.Location
            data currentFolder = Path.GetDirectoryName(assemblyLocation)
            data rootPath = Path.GetPathRoot(currentFolder)
            while(currentFolder != rootPath)
            begin
                if(Directory.Exists(Path.Combine(currentFolder, folderName))) then
                    mreturn Path.Combine(currentFolder, folderName)
                else
                    currentFolder = Path.GetFullPath(currentFolder + "..\")
            end
            mreturn ^null
        endmethod

    endclass

endnamespace
