// package main declares the package name
// main package is special in Go. it is where the execution of program starts.
package main

// import "fmt" imports the "fmt" package which contains functions for formatted I/O
import (
	//"log"
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)
// func main() defines the main function. this is the entry point for the application
// when you run the program, it starts executing the function

func main() {
  plugin.Serve(&plugin.ServeOpts{
	ProviderFunc: Provider,
  }) 
  fmt.Println("Hello, World!")
}

//in golang a titlecase function will get exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap:  map[string]*schema.Resource{
			//"terratowns_home": Resource(),
		},
		DataSourcesMap:  map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for hte external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // make the token as sensitive to hide it the logs
				Required: true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc: validateUUID,
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
// 	log.Print("validateUUID:start")
// 	value := v.(string)
// 	if _, err := uuid.Parse(value); err != nil {
// 		errors = append(errors, fmt.Errorf("invalid UUID format"))
// 	}
// 	log.Print("validateUUID:end")
// 	return
// }
