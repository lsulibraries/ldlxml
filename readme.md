Metadata Creation Process

Rachel M Tillay

9/21/15

General Description of the Process

1.  Gather all possible sources of metadata for the objects being described

2.  Consult with subject and cataloging specialists

3.  Compare existing metadata and required subject coverage to the metadata standards/schema being used

4.  Create a sample metadata record

5.  Get the sample metadata record approved by content submitter, subject specialist, and cataloger/metadata librarian

6.  Create any new metadata, if necessary, using a consistent process

7.  Create automated process to harvest and convert the metadata from any existing records and merge with the newly created metadata

8.  Have content submitter, subject specialist, and cataloger/metadata librarian review a sample of the created records for accuracy and completion

Specific Example of the Process (Creation of Metadata for Historic Theses and Dissertations)

1.  Harvested the data in the ProQuest records and the catalog records in MARCEdit.

2.  Meeting with Linda, Tina, Catherine, Bill, Mike, and Rachel to discuss the contents of those records and how they compare to one another. Attempted to clarify which fields we would want to pull from which records. That data is described in: S:\\Departments\\Digital Services\\External\\Cataloging Collaboration\\LDL Cataloging Standards\\MODS for ETDs worksheet.docx

3.  Decided to use MODS for the final metadata records, and follow the Texas Digital Library’s metadata for theses standard ([www.tdl.org/files/tdl-descriptive-metadata-guidelines-for-etd-v1.pdf](http://www.tdl.org/files/tdl-descriptive-metadata-guidelines-for-etd-v1.pdf)).

4.  Created a sample record that includes the data from the MARC and Proquest and notes the data that is missing that TDL requires or recommends: <https://github.com/lsulibraries/ldlxml/blob/master/mods/ETD/0000418_editingsuggestions.xml>

5.  Shared record with committee described in step 2. Refinements are also described in the document in step 2.

6.  We could not create new data for this collection at the item level due to the number of items, but some new data (like location) is created through the automated processes described in step 7.

7.  This part of the process is still being refined. For now, the steps we have followed include:

    1.  Reharvest ProQuest and Catalog records into MARCEdit.

    2.  Adlfjalsdkf?

    3.  Aldskfjlaskdfj?

    4.  Export cleaned records into MARCXML.

    5.  Import MARCXML into Oxygen, and clean further. Specifically make sure the 22<sup>nd</sup> character in 008 is 0, and make sure all 008 fields occur before 035 fields.

    6.  Using most recent MARC21slim transformation sheet from Library of Congress, build a transformation that uses as much of that code as possible. Currently, that involves editing it to include all of the namespaces we need at the top of the stylesheet, adding an empty template so that additional data can be added by overriding the template in nested stylesheets, and ???. The LSUMarc transformation sheet includes many more empty templates and some data (LSU location, etc.) that will be used for every MARC transformation. A collection-specific transformation sheet (in this case coll-ETD) fills in the data necessary for the templates being used on this set of records.

8.  Not yet completed.
