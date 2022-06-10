# Technology add-on for Exim MTA

Technology add-on for Exim MTA allows for parsing fields from logs generated by Exim - popular open source mail server. Currently only EXIM main log is supported and extensive work has been done to make sure that relevant fields are made CIM compliant against Email data model.  

## System Requirements
None

## Installation
- Install on Search Head for search-time parsing and CIM compliance
- Install on Indexer or Heavy Forwarder for optimized indexed-time parsing rules

## Capabilities
- index-time parsing
- search-time parsing
- scheduled search to periodically push aggregated email processing events into a summary index
- Accelerated data model Email periodically filled with new events from a summary index  

## Configuration
Exim server just like other email servers or email proxy servers generate a single event as an atomic activity for either incoming or outgoing email. In order to have a summarized condenced information about each email transaction (sender, receiver, message size, status, verdicts, attachments, etc.) we are using a summary index and a scheduled search that reguarly fills this summary index. On Splunk Search Head you need to enable a scheduled search "Exim - Mail Processing - Summary Gen" as follows:

1. Make TA_exim app visible 
2. Open a folder http://<your splunk host>:8000/en-US/app/TA_exim/reports
3. Enable end schedule the search "Exim - Mail Processing - Summary Gen"; 5 min by default
4. (optional) Update macros `exim_index` and `exim_summary_index` used by the search above. By default "exim_index=exim", "exim_summary_index=exim_summary"
5. Make TA_exim app invisible again

## Usage
To work with Exim main log data you have three options:
- Exim raw events
`sourcetype=exim:main`
- Exim summary
`sourcetype=exim:transactions`
- Email Data Model
`|tstats count from datamodel=Email.All_Email`

## Development Notes
- Search-time parsing is based primarily on highly hierarchical design of many nested transforms in transforms.conf. Curent design of transforms.conf allows for additional fine-grained parsing of previous blocks in the future. 
- Soft fine tuning done in props.conf

## CIM Data Model Compliance
- Splunk CIM Data Models supported = Email
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

- Dataset All_Email.Contenet
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

## Feedback
I am open for any feedback at tomik.moser@gmail.com

## Release Notes
- 1.0.0, 2022-06-10, initial release
