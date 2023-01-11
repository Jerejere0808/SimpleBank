package db

import (
	"BANK/util"
	"database/sql"
	"fmt"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
	fmt.Println("before")
	var err error
	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("Can't load config:", err)
	}
	testDB, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("unable to use data source name:", err)
	}
	testQueries = New(testDB)

	os.Exit(m.Run())
	fmt.Println("after")
}
