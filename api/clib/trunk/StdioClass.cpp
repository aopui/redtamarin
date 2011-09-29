/* -*- Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

#include "avmshell.h"

namespace avmshell
{

    StdioClass::StdioClass(VTable *cvtable)
    : ClassClosure(cvtable)
    {
        createVanillaPrototype();
    }

    StdioClass::~StdioClass()
    {
        
    }

    int StdioClass::get_FILENAME_MAX()
    {
        return FILENAME_MAX;
    }
    
    int StdioClass::get_PATH_MAX()
    {
        return PATH_MAX;
    }

    int StdioClass::get_NONBLOCKING_DISABLE()
    {
        return NONBLOCKING_DISABLE;
    }

    int StdioClass::get_NONBLOCKING_ENABLE()
    {
        return NONBLOCKING_ENABLE;
    }

    int StdioClass::get_O_TEXT()
    {
        return O_TEXT;
    }
    
    int StdioClass::get_O_BINARY()
    {
        return O_BINARY;
    }

    


    int StdioClass::remove(Stringp filename)
    {
        if (!filename) {
            toplevel()->throwArgumentError(kNullArgumentError, "filename");
        }

        StUTF8String filenameUTF8(filename);
        return VMPI_remove(filenameUTF8.c_str());
    }
    
    int StdioClass::rename(Stringp oldname, Stringp newname)
    {
        Toplevel* toplevel = this->toplevel();
        
        if (!oldname) {
            toplevel->throwArgumentError(kNullArgumentError, "oldname");
        }
        
        if (!newname) {
            toplevel->throwArgumentError(kNullArgumentError, "newname");
        }
        
        StUTF8String oldnameUTF8(oldname);
        StUTF8String newnameUTF8(newname);
        return VMPI_rename(oldnameUTF8.c_str(), newnameUTF8.c_str());
    }

    void StdioClass::con_stream_mode(int state)
    {
        VMPI_con_stream_mode( state );
    }

    void StdioClass::con_trans_mode(int state)
    {
        VMPI_con_trans_mode( state );
    }

    int StdioClass::kbhit()
    {
        return VMPI_kbhit();
    }

}
