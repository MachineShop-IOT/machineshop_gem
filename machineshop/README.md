# MachineShop

Wraps the machineshop API

## Installation

Add this line to your application's Gemfile:

    gem 'machineshop'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install machineshop



## Usage

### Authentication 
Allow a user to authenticate

    auth_token, user = MachineShop::User.authenticate(
        :email => "username",
        :password => "password"
    )   

---
* ##### Http_method : Post

* ##### Parameters :
 * email _string_
 * password _string_

* ##### Response Example

----
    {
    "id" => "8e98188e981800aaef000001",
        "_id" => "8e98188e981800aaef000001",
        "authentication_token" => "2jzZhuHWLZy9fsxcd36E",
        "company_name" => "company_name",
        "current_sign_in_at" => "2014-06-09T08:26:06Z",
        "current_sign_in_ip" => "202.51.76.235",
        "domain" => "john@domain.com",
        "email" => "admin@domain.com",
        "first_name" => "First_name",
        "keychain" => {},
        "last_name" => "Last_name",
        "last_sign_in_at" => "2014-06-09T08:26:06Z",
        "last_sign_in_ip" => "202.51.76.235",
        "logo_url" => nil,
        "name_space" => [
            [0]
            "test"
    ],
        "notification_method" => "sms",
        "phone_number" => "+1 (123) 456-7890",
        "role" => "admin",
        "sign_in_count" => 234,
        "tag_ids" => [],
        "http_code" => 200
}

### Get All user roles 
Get all the roles assigned to the current user

        MachineShop::User.all_roles(auth_token)

---
* ##### Http_method : Get

* ##### Parameters :
 * auth_token ___ _string_
  > obtained from #authentication

* ##### Response Example

----
    [
    "admin",
    "publisher",
    "consumer"]

----
### Retrieve user
Get User object to apply the following actions

> user.update,
> user.delete


        MachineShop::User.retrieve(user_id, auth_token)

---
* ##### Http_method : Get

* ##### Parameters :
 * auth\_token _string_
 * user\_id:   _string_
  > available in response object from #authentication

* ##### Response Example

 > Same as from authenticate


### Get the devices of the current user

        MachineShop::Device.all(
        {:page => 1,
         :per_page => 10},
        auth_token)

---
* ##### Http_method : Get

* ##### Parameters :
 * page _Integer_
 > page number for pagination

 * name _string_
 > get device by name

 * per\_page:   _Integer_
 > Number of items to display
 * auth\_token

* ##### Response Example

----

    [{
    "id": "9584216470180077f7000157",
    "_id": "9584216470180077f7000157",
    "active": true,
    "created_at": "2014-06-09T09:16:06Z",
    "deleted_at": null,
    "exe_path": "/etc/foo",
    "image_url": "http://someurl.com/your_image.png",
    "init_cmd": "my_init_cmd",
    "init_params": "{'init':'go'}",
    "last_known_translator_port": null,
    "long_description": "This device tracks position and test.",
    "manual_url": "http://someurl.com/manual.pdf",
    "manufacturer": "a company",
    "model": "D-vice 1000",
    "name": "my_device",
    "rule_ids": [],
    "sample_data": "some arbitrary sample data",
    "software": null,
    "tag_ids": [],
    "translator": null,
    "type": "Test",
    "unit_price": "$199.99",
    "updated_at": "2014-06-09T09:16:06Z",
    "user_id": "11161696201800aaef0000459}, {
    "id": "2065309466180077f7000157",
    "_id": "2065309466180077f7000157",
    "active": true,
    "created_at": "2014-06-09T09:15:01Z",
    "deleted_at": null,
    "exe_path": "/etc/foo",
    "image_url": "http://someurl.com/your_image.png",
    "init_cmd": "my_init_cmd",
    "init_params": "{'init':'go'}",
    "last_known_translator_port": null,
    "long_description": "This device tracks position and btest.",
    "manual_url": "http://someurl.com/manual.pdf",
    "manufacturer": "a company",
    "model": "D-vice 1000",
    "name": "my_device",
    "rule_ids": [],
    "sample_data": "some arbitrary sample data",
    "software": null,
    "tag_ids": [],
    "translator": null,
    "type": "Test",
    "unit_price": "$199.99",
    "updated_at": "2014-06-09T09:15:01Z",
    "user_id": "11161696201800aaef0000459"} ]



### Retrieve Device 

    specificDevice = MachineShop::Device.retrieve(device_id, auth_token)

---
* ##### Http_method : Get

* ##### Parameters :
 * device\_id
 > device id

 * auth\_token

* ##### Response Example

----

    {
    "id" => "51795428911800d51400016c",
        "_id" => "51795428911800d51400016c",
        "active" => true,
        "created_at" => "2014-06-09T10:02:50Z",
        "deleted_at" => nil,
        "exe_path" => "/etc/foo",
        "image_url" => "http://someurl.com/your_image.png",
        "init_cmd" => "my_init_cmd",
        "init_params" => "{'init':'go'}",
        "last_known_translator_port" => nil,
        "long_description" => "This device tracks position and NCAA football conference.",
        "manual_url" => "http://someurl.com/manual.pdf",
        "manufacturer" => "a company",
        "model" => "D-vice 1000",
        "name" => "my_device",
        "rule_ids" => [],
        "sample_data" => "some arbitrary sample data",
        "software" => nil,
        "tag_ids" => [],
        "translator" => nil,
        "type" => "Test",
        "unit_price" => "$199.99",
        "updated_at" => "2014-06-09T10:02:50Z",
        "user_id" => "11161696201800aaef000056",
        "http_code" => 200}


### Create device instance for the device

    device_instance = specificDevice.create_instance(
    {
        :name => "My little instance",
        :active => "yes"
    }

---
* ##### Http_method : Post

* ##### Parameters :
 * name
 * active

* ##### Response Example

----

    {
    "id" => "30048840211800a9c600000c",
        "_id" => "30048840211800a9c600000c",
        "tag_ids" => [],
        "rule_ids" => [],
        "alert_count" => 0,
        "name" => "My little instance",
        "active" => true,
        "device_id" => "531eafcb38300488402145",
        "user_id" => "11800a9c1800aaef0004543",
        "auth_token" => nil,
        "updated_at" => "2014-03-11T06:41:42Z",
        "created_at" => "2014-03-11T06:41:42Z",
        "http_code" => 200}

---


### Create a device

Create a new device

    newDevice = MachineShop::Device.create(
        {
            :name =>  "my_device",
            :type => "Test",
            :manufacturer =>  "a company",
            :model =>  "D-vice 1000",
            :active =>  "yes",
            :init_cmd =>  "my_init_cmd",
            :init_params =>  "{'init':'go'}",
            :exe_path =>  "/etc/foo",
            :unit_price =>  "$199.99",
            :sample_data =>  "some arbitrary sample data",
            :long_description =>  "This device tracks position of test.",
            :image_url =>  "http://someurl.com/your_image.png",
            :manual_url =>  "http://someurl.com/manual.pdf"},auth_token)

---

* Http_method : Post 


> Alternately the device instance can be created from this object as well 

    newDevice.create_instance(
        {
            :name => "My little instance",
            :active => "yes"
        }
    )


### Get the device instances
Get all the device instances of the user

    MachineShop::DeviceInstance.all({:name => "instance_name"}, auth_token)

---
> Pass first parameter as empty array if no filters to be applied 

* ##### Http_method : Get

* ##### Parameters 
 * auth_token
 * filter_parameters

 * * name

* ##### Response Example

----

    {
    "id" => "51795428911800d51400016c",
        "_id" => "51795428911800d51400016c",
        "active" => true,
        "created_at" => "2014-06-09T10:02:50Z",
        "deleted_at" => nil,
        "exe_path" => "/etc/foo",
        "image_url" => "http://someurl.com/your_image.png",
        "init_cmd" => "my_init_cmd",
        "init_params" => "{'init':'go'}",
        "last_known_translator_port" => nil,
        "long_description" => "This device tracks position and NCAA football conference.",
        "manual_url" => "http://someurl.com/manual.pdf",
        "manufacturer" => "a company",
        "model" => "D-vice 1000",
        "name" => "my_device",
        "rule_ids" => [],
        "sample_data" => "some arbitrary sample data",
        "software" => nil,
        "tag_ids" => [],
        "translator" => nil,
        "type" => "Test",
        "unit_price" => "$199.99",
        "updated_at" => "2014-06-09T10:02:50Z",
        "user_id" => "11161696201800aaef000056",
        "http_code" => 200}


> Another way 

    user.device_instances({:name => device_instance.name})
or without filters 

    user.device_instances
> Where user is the user object from the #Authenticate or retrieved user

    specificDevice.instances
> where specficiDevice is the object from retrieve



### Create Customers


    specificCustomer =MachineShop::Customer.create({:email=>"test@domain.com",
                                             :password=>'password',
                                             :notification_method=>'sms',
                                             :first_name=>'John',:last_name=>'Doe',
                                             :phone_number=>'98989898989',
                                             :company_name=>'technology co'

                                            },auth_token)

---
* ##### Http_method : Post

* ##### Parameters 

 * Post parameters:  _array of params_ 
 * auth_token

* ##### Response Example

----

    {
    "id" => "958421647080007a004506b",
        "_id" => "958421647080007a004506b",
        "email" => "test@domain.com",
        "domain" => "machineshop",
        "sign_in_count" => 0,
        "keychain" => {},
        "notification_method" => "sms",
        "first_name" => "John",
        "last_name" => "Doe",
        "phone_number" => "98989898989",
        "company_name" => "technology co",
        "publisher_id" => "3004884021800aaef0056893",
        "role" => "consumer",
        "logo_url" => nil,
        "name_space" => [
            [0]
            "csr"
    ],
        "authentication_token" => "YLMDGOvdjyucLvwaJKfu",
        "http_code" => 200
}

---
### Retrieve Customer
Retrieve customer by Id


    retrievedCustomer = MachineShop::Customer.retrieve(customer_id, auth_token)

---
* ##### Http_method : Get

* ##### Parameters 

 * customer\_id _string_
 * auth_token

* ##### Response Example

----
    same as above

----

### Update Customer by Id


    MachineShop::Customer.update(customer_id,auth_token,{:notification_method => 'email'})


---
* ##### Http_method : Put

* ##### Parameters 

 * customer_id:  _string_ 
 * update parameters:  _array of params_ 
 * auth_token

* ##### Response Example

----

    {
    "id": "958421647080007a004506b",
    "_id": "958421647080007a004506b",
    "email": "test@domain.com",
    "domain": "machineshop",
    "sign_in_count": 0,
    "keychain": {},
    "notification_method": "sms",
    "first_name": "John",
    "last_name": "Doe",
    "phone_number": "98989898989",
    "company_name": "technology co",
    "publisher_id": "3004884021800aaef0056893",
    "role": "consumer",
    "logo_url": null,
    "name_space": ["csr"],
    "authentication_token": "YLMDGOvdjyucLvwaJKfu",
    "http_code": 200
}


> Alternately 

    retrieved_cust.update({:notification_method => 'email'})


### Delete Customer
Delete the Customer

    retrievedCustomer.delete

---
> retrievedCustomer is the retrieved customer object

* ##### Http_method : delete


* ##### Response Example

----

    {"http_code":200,"deleted":true}



### List rules
List all the rules of user

    MachineShop::Rule.all({},auth_token)

---
> Filter parameters else empty array 

* ##### Http_method : Get

* ##### Parameters 

 * filter parameters:  _array of params_ 
 * auth_token

* ##### Response Example

----

    {
    "id": "958421647080007a004506b",
    "_id": "958421647080007a004506b",
    "actions": [{
        "id": "958421647080007a0045062",
        "_id": "958421647080007a0045062",
        "send_to": "john@mach19.com",
        "_type": "EmailAction"
    }, {
        "id": "958421647080007a0045063",
        "_id": "958421647080007a0045063",
        "send_to": "14794263982",
        "_type": "SmsAction"
    }],
    "active": true,
    "comparison_value": "0",
    "created_at": "2012-09-26T20:33:19Z",
    "deleted": false,
    "deleted_at": null,
    "description": "testing stage rule",
    "device_attribute": "stage",
    "device_ids": [],
    "device_instance_ids": ["503900d2ab400015a5731125"],
    "downstream_rule_id": null,
    "last_run": "2012-09-28T18:53:58Z",
    "last_run_status": "pass",
    "modified_date": "2012-09-26T20:33:19Z",
    "operator": "gt",
    "plain_english": "This rule has no conditions.",
    "rule_histories": [],
    "tag_ids": [],
    "updated_at": "2012-09-28T18:53:58Z",
    "user_id": "3004884021800aaef0056893"}

---


### Create Rule
Create a rule

    create_hash = {
      :devices=>["52585e1d981800bab2000479"],
      :device_instances=>[],
      :rule=>{
          :active=>true,
          :description=>"test",
          :condition=>{
              :type=>"and_rule_condition",
              :rule_conditions=>[{

                  :property=>"var",
                  :value=>"30",
                  :type=>"equal_rule_condition"

              }]
          },
          :then_actions=>[{
              :priority=>"1",
              :send_to=>"abc@me.com",
              :type=>"email_rule_action"
          }]
      }  }

    createdRule = MachineShop::Rule.create(create_hash,auth_token)

* ##### Http_method : Post

* ##### Parameters 

 * create parameter:  _json array of params_ 
 * auth_token

* ##### Response Example

----

    {
    "id" => "5395b245385f7fe266000037",
        "_id" => "5395b245385f7fe266000037",
        "active" => true,
        "created_at" => "2014-06-09T13:10:31Z",
        "deleted_at" => nil,
        "description" => "test",
        "device_ids" => [],
        "device_instance_ids" => [],
        "downstream_rule_id" => nil,
        "last_run_status" => "pass",
        "plain_english" => "If var is equal to 30 then send an email to abc@me.com. Otherwise do nothing.    ",
        "tag_ids" => [],
        "then_actions" => [
            [0] {
                "id" => "5395b247385f7fe26600003a",
                    "_id" => "5395b247385f7fe26600003a",
                    "created_at" => nil,
                    "deleted_at" => nil,
                    "priority" => "1",
                    "send_to" => "abc@me.com",
                    "updated_at" => nil,
                    "type" => "email_rule_action"
            }
    ],
        "updated_at" => "2014-06-09T13:10:31Z",
        "user_id" => "52160c8e981800aaef000001",
        "http_code" => 200}


----



### Retrieve Rule
    specificRule = MachineShop::Rule.retrieve("rule_id",auth_token)
    
* ##### Http_method : Get

* ##### Parameters 

 * rule\_id:  _string_ 

 * auth_token

* ##### Response Example

----

     {
    "id" => "5395b245385f7fe266000037",
        "_id" => "5395b245385f7fe266000037",
        "active" => true,
        "created_at" => "2014-06-09T13:10:31Z",
        "deleted_at" => nil,
        "description" => "test",
        "device_ids" => [],
        "device_instance_ids" => [],
        "downstream_rule_id" => nil,
        "last_run_status" => "pass",
        "plain_english" => "If var is equal to 30 then send an email to abc@me.com. Otherwise do nothing.    ",
        "tag_ids" => [],
        "then_actions" => [
            [0] {
                "id" => "5395b247385f7fe26600003a",
                    "_id" => "5395b247385f7fe26600003a",
                    "created_at" => nil,
                    "deleted_at" => nil,
                    "priority" => "1",
                    "send_to" => "abc@me.com",
                    "updated_at" => nil,
                    "type" => "email_rule_action"
            }
    ],
        "updated_at" => "2014-06-09T13:10:31Z",
        "user_id" => "52160c8e981800aaef000001"}

---

### Delete Rule
Delete the rule

    specificRule.delete

> specificRule is the retrieve rule object

* ##### Http_method : Delete

* ##### Response Example

----
    
    {"http_code":200,"deleted":true}

----

###  Get join rule conditions
Get join rule conditions

    MachineShop::Rule.get_join_rule_conditions(auth_token)
    
* ##### Http_method : Get

* ##### Parameters 


 * auth_token

* ##### Response Example

----
    [
    ["A few conditions where only one needs to be true.", "or_rule_condition"],
    ["A few conditions that must all be true.", "and_rule_condition"]]

----

###  Get comparison rule_conditions

    MachineShop::Rule.get_comparison_rule_conditions(auth_token)
    
* ##### Http_method : Get

* ##### Parameters 


 * auth_token

* ##### Response Example

----
    [
    [
        ["A numeric payload value is greater than a specified threshold."]
        ["greater_than_rule_condition"]
    ],
    [
        ["A payload value is not the same as the specified value."]
        ["not_equal_rule_condition"]
    ]]

----


###  Get rule by device_instance id
    MachineShop::Rule.get_by_device_instance(auth_token,'device_instance_id')
    
* ##### Http_method : Get

* ##### Parameters 
 * device_instance_id


 * auth_token

* ##### Response Example

----
    {: _id => "958421647080007a004506b",
    : active => true,
    : created_at => "2014-02-05T21:22:53Z",
    : deleted_at => nil,
    : description => "testsamplems",
    : device_ids => [],
    : device_instance_ids => ["52b20004758a004506800ba8"],
    : downstream_rule_id => nil,
    : last_run_status => "pass",
    : plain_english => "If temp is equal to 44 then send an email to test@domain.com. Otherwise do nothing.    This rule applies to these device instances: test_device.",
    : tag_ids => [],
    : then_actions => [{: _id => "506852b0475004a800b2008a",
        : created_at => nil,
        : deleted_at => nil,
        : priority => "1",
        : send_to => "test@domain.com",
        : updated_at => nil,
        : type => "email_rule_action"
    }],    : updated_at => "2014-02-05T21:22:53Z",
    : user_id => "3004884021800aaef0056893"}

----

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request