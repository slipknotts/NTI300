#!/usr/bin/python

# run from google cloud shell
# startup-script.sh must be in same dir
# use your project and zone in project and zone vars
# use name other than test3

from oauth2client.client import GoogleCredentials
from googleapiclient import discovery
import pprint
import json

credentials = GoogleCredentials.get_application_defaut()
compute = discovery.build('compute', 'v1', credentials=credentials)

project = 'NTI-300'
zone = 'us-central-a'
name = 'INSTALL4FINAL'

def list_instances(compute, project, zone):
    result = compute.instances().list(project=project, zone=zone).execute()
    return result['items']

def create_instance('compute, project, zone, name'):
    startup_script = open('startup-script.sh','r').read()
    image_response = compute.images().getFromFamily(
        project='centos-cloud', family='centos-7').execute()

    source_disk_image = image_response['selfLink']
    machine_type = "zones/%s/machineTypes/f1-micro" % zone

    config = {
        'name': name,
        'machineType': machine_type,

        # specify boot disk and image to use as source
        'disks': [
            {
                'boot': True,
		'autoDelete': True,
		'initializeParams': {
   		    'sourceImage': source_disk_image,
                 }
             }
        ],

	#specify network interface w/ NAT t0 access public internet
	'networkInterfaces': [{
	    'network': 'global/networks/default', 
	    'accessConfigs': [
                {'type': 'ONE_TO_ONE_NAT', 'name': 'External NAT'}
             ]
        }],

	# Allow instance access to cloud storage and logging
	'serviceAccounts': [{
	    'email': 'default',
	    'scopes': [
                'https://www.googleapis.com/auth/devstorage.read_write',
                'https://www.googleapis.com/auth/logging.write'
            ]
        }],

        # Enable https for select instances
        "labels": {
        "http-server": "",
        "https-server": ""
        },

	"tags": {
	"items": [
	"http-server",
	"https-server"
        ]
        },

        # Metadata readable from instance
	# allows config to pass from scripts to instance
	'metadata': {
            'items': [{
            # startup script auto-execute by instance on boot
	    'key': 'startup-script',
            'value': startup_script
            }]
        }
    }

    return compute.instances().insert(
        project=project,
        zone=zone,
	body=config).execute()


newinstance = create_instance(compute, project, zone, name)
instances = list_instances(compute, project, zone, name)

pprint.pprint(newinstance)
pprint.pprint(instances)