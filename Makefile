# Makefile version 1.0.1


APP="TA_exim.tgz"
APP_DIR="TA_exim"

SC_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7InVpZCI6IjYwNTgwMyIsInVuYW1lIjoidG9tYXNtb3NlciIsIm5hbWUiOiJUb21hcyBNb3NlciIsImVtYWlsIjoidG9tYXMubW9zZXJAYWxlZi5jb20iLCJkYXRlX3JlZyI6IjE0MDI3NjU4OTUiLCJzdGF0ZSI6IjMiLCJva3RhX2lkcF9pZCI6IjAwdTF6NTljdzR5cENSWm92MnA3Iiwic2FsZXNmb3JjZV9pZCI6IjAwMzQwMDAwMDFTQUNNS0FBNSIsInNhbGVzZm9yY2VfdXNlcl9pZCI6IjAiLCJsZGFwX2RuIjoiIiwiaXNfb25ldGltZV9lbWFpbF9ieXBhc3Nfb24iOiIwIiwicGFyZW50cyI6WyJCZXRhIFVzZXJzIiwid2FpdG9tb19saW1fYXZhaWxfdXNlciJdLCJ2YWxpZGF0ZWRfZW1haWwiOiJ2YWxpZGF0ZWQiLCJzaWdudXBfdHlwZSI6InJlZ3VsYXIiLCJpc190cm9vcF9pZF92YWxpZGF0ZWQiOmZhbHNlfSwiaWF0IjoxNTk0MzEyODg4LCJleHAiOjE1OTQzOTkyODgsImF1ZCI6InNwbHVuay5jb20iLCJpc3MiOiJzcGx1bmsuY29tIn0.lD7nihh5dtqk_EB0TQrMzXfYEcyPo088fOjEswgx2rM"

REQID="7dbc3810-03dd-40ac-be42-3d3f2e4c5ab5"

SPLUNKBASE_EXCLUDE = "splunkbase_exclude.txt"
RELEASE = $(shell cat default/app.conf | grep version | cut -f2 -d= | sed -E 's/ +//')

sc_vetting_submit:
	find -L ./${APP_DIR} -type f -name "*.py[co]" -exec rm {} \; 
	tar cvzhf ${APP} ${APP_DIR}
	curl -X POST \
     -H "Authorization: bearer $(SC_TOKEN)" \
     -H "Cache-Control: no-cache" \
     -F "app_package=@\"./$(APP)\"" \
     --url "https://appinspect.splunk.com/v1/app/validate"	

sc_vetting_status:
	curl -X GET \
    -H "Authorization: bearer $(SC_TOKEN)" \
        --url "https://appinspect.splunk.com/v1/app/validate/status/$(REQID)"

sc_vetting_report:
	curl -X GET \
	-H "Authorization: bearer $(SC_TOKEN)" \
	-H "Cache-Control: no-cache" \
	-H "Content-Type: text/html" \
	--url "https://appinspect.splunk.com/v1/app/report/$(REQID)"

gen_package:
	echo "Creating release $(RELEASE) for Splunkbase"; \
	cd ..; \
	rm -f $(APP)-*; \
	tar -X $(APP_DIR)/$(SPLUNKBASE_EXCLUDE) -cvzf $(APP_DIR)-$(RELEASE).tar.gz $(APP_DIR)

all: gen_package
