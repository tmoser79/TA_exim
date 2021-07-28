Splunk Technology add-on for Exim MTA

* Facts
- add-on is built using Splunk Add-on Builder and manual work
- add-on is very handy to verify CIM compliance using its GUI

* TA add-on Capabilties
- index-time parsing
- search-time parsing
- scheduled search to periodically push aggregated email processing events into a summary index
- Accelerated Data model Email periodically filled with new data from a summary index  

* TA add-on architecture
- search-time parsing based primarily on highly hierarchical design of many nested transforms in transforms.conf
-- design of transforms.conf allows for additional fine-grained parsing of previous blocks 
- soft fine tuning done in props.conf

* Summary Index
- summary generating search aggregates raw events into events where is clear who sent to whom and with what results:
`_time, src_user, recipient, flag, flag_desc, action, filter_action, ...`
- summary index has a default name "exim_summary"
- summary index stores data with the sourcetype "stash" to safe Splunk license (stash data not licensed)

* Data Model Filling
- Data model Email is filled automatically based on eventtypes.conf and tags.conf configuration definitions. 
- set DM acceleration history as you wish 

* CIM Data Model Compliance
- DM = Email
- There are many fields that have been extracted from raw data (partical CIM compliance)
- There is plenty of room for an improvement to parse more fields

- Dataset All_Email.Delivery:
internal_message_id
message_id
protocol
size
status_code
subject
action
dest
src
recipient
recipient_domain
src_user
src_user_domain
vendor_product

- Dataset All_Email.Filtering:
filter_action
internal_message_id
message_id
protocol
size
status_code
subject
action
dest
src
recipient
recipient_domain
src_user
src_user_domain
vendor_product
