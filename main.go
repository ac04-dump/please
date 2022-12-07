package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"
)

func GetExecutablePath(exe string) (string, error) {
	fname, err := exec.LookPath(os.Args[1])
	if err != nil {
		return "", err
	}

	return filepath.Abs(fname)
}

func main() {
	exePath, err := GetExecutablePath(os.Args[1])
	if err != nil {
		fmt.Printf("Error: Cannot get full path of %s: %s\n", os.Args[1], err.Error())
		return
	}

	fmt.Printf("running as root: %s %s\n", exePath, strings.Join(os.Args[2:], " "))

	err = syscall.Exec(exePath, os.Args[1:], os.Environ())
	if err != nil {
		fmt.Printf("Error running exec: %s\n", err.Error())
		return
	}
}
