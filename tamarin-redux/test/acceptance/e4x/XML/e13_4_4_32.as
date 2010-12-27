/* -*- Mode: java; tab-width: 8; indent-tabs-mode: nil; c-basic-offset: 4 -*-
 *
 * ***** BEGIN LICENSE BLOCK *****
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
 * The Original Code is Rhino code, released
 * May 6, 1999.
 *
 * The Initial Developer of the Original Code is
 * Netscape Communications Corporation.
 * Portions created by the Initial Developer are Copyright (C) 1997-2000
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Igor Bukanov
 *   Ethan Hugg
 *   Milen Nankov
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

import avmplus.System

START("13.4.4.32 - XML replace()");

//TEST(1, true, XML.prototype.hasOwnProperty("replace"));

// Replace the first employee record with an open staff requisition
emps =
<employees>
    <employee id="0"><name>Jim</name><age>25</age></employee>
    <employee id="1"><name>Joe</name><age>20</age></employee>
</employees>;

correct =
<employees>
    <requisition status="open" />
    <employee id="1"><name>Joe</name><age>20</age></employee>
</employees>;

emps.replace(0, <requisition status="open" />);

TEST(2, correct, emps);

// Replace all children with open staff requisition

emps =
<employees>
    <employee id="0"><name>Jim</name><age>25</age></employee>
    <employee id="1"><name>Joe</name><age>20</age></employee>
</employees>;

correct =
<employees>
    <requisition status="open" />
</employees>;

emps.replace("*", <requisition status="open" />);

TEST(3, correct, emps);

// Replace all employee elements with open staff requisition

emps =
<employees>
    <employee id="0"><name>Jim</name><age>25</age></employee>
    <employee id="1"><name>Joe</name><age>20</age></employee>
</employees>;

correct =
<employees>
    <requisition status="open" />
</employees>;

emps.replace("employee", <requisition status="open" />);

TEST(4, correct, emps);

XML.prettyPrinting = false;
var xmlDoc = "<employee id='1'><firstname>John</firstname><lastname>Walton</lastname><age>25</age></employee>"

// propertyName as a string
AddTestCase( "MYXML = new XML(xmlDoc), MYXML.replace(0,'Mr. John')", 
	"<employee id=\"1\">Mr. John<lastname>Walton</lastname><age>25</age></employee>", 
             (MYXML = new XML(xmlDoc), MYXML.replace(0,'Mr. John').toString()));

xmlDoc = "<employee id='1'><firstname>John</firstname><lastname>Walton</lastname><age>25</age></employee>"

AddTestCase( "MYXML = new XML(xmlDoc), MYXML.replace('phone','542144')", 
	"<employee id=\"1\"><firstname>John</firstname><lastname>Walton</lastname><age>25</age></employee>", 
             (MYXML = new XML(xmlDoc), MYXML.replace('phone','542144').toString()));

AddTestCase( "MYXML = new XML(xmlDoc), MYXML.replace('firstname','Johnny')", 
	"<employee id=\"1\">Johnny<lastname>Walton</lastname><age>25</age></employee>", 
             (MYXML = new XML(xmlDoc), MYXML.replace('firstname','Johnny').toString()));

var expectedResult;
if (System.swfVersion < 10)
    expectedResult = '<employee id="1"><phone>1234567</phone></employee>';
else
    expectedResult = '<phone>1234567</phone>';

// This should replace all the children
AddTestCase( "MYXML = new XML(xmlDoc), MYXML.replace('*','<phone>1234567</phone>')", 
	expectedResult, 
             (MYXML = new XML(xmlDoc), MYXML.replace('*',"<phone>1234567</phone>").toString()));

// What about using an attribute name as a input parameter
// !!@ Rhino does an attribute addition after id!?!?
AddTestCase( "MYXML = new XML(xmlDoc), MYXML.replace('@phone','<phone>7654321</phone>')", 
	"<employee id=\"1\"><firstname>John</firstname><lastname>Walton</lastname><age>25</age></employee>", 
             (MYXML = new XML(xmlDoc), MYXML.replace('@phone',"<phone>7654321</phone>").toString()));



END();