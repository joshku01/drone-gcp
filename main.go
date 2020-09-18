package main

import (
	"github.com/gin-gonic/gin"
	"os"
)

func main() {
	host, _ := os.Hostname()
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": host,
			"Version": "1.0.0",
		})
	})
	r.Run()
}
