package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
	"strings"
)

var wordRegex *regexp.Regexp = regexp.MustCompile(`([A-Za-z][A-Za-z0-9]{2,12}-[A-Za-z0-9]{3,10}|([0-9]{1,3}\.){3}[0-9]{1,3})`)
var ipaddrRegex *regexp.Regexp = regexp.MustCompile(`([0-9]{1,3}\.){3}[0-9]{1,3}`)

func searchInternalDB(internaldb string, s string) string {
	ipaddr := false
	if ipaddrRegex.MatchString(s) {
		ipaddr = true
	}

	for _, line := range strings.Split(internaldb, "\n") {
		words := strings.Fields(line)
		if len(words) < 2 {
			continue
		}
		word := words[0]
		if ipaddr {
			word = words[len(words)-1]
		}
		if s == word {
			if ipaddr {
				return words[0]
			}
			return words[len(words)-1]
		}
	}

	return string("")
}

func processLine(s string) []string {
	return wordRegex.FindAllString(s, -1)
}

func main() {
	// comprobamos que el stdin tenga datos
	fi, err := os.Stdin.Stat()
	if err != nil {
		panic(err)
	}
	if fi.Mode()&os.ModeNamedPipe == 0 {
		panic("No data on stdin.")
	}

	// Abrimos el fichero del internal.db
	f, err := ioutil.ReadFile(os.Getenv("HOME") + "/Syncthing/TES/gitlab/tcdn/sistemas/internaldns/db.transparent")
	if err != nil {
		fmt.Println(err)
		return
	}
	internaldb := strings.ReplaceAll(string(f), "\r\n", "\n")

	scanner := bufio.NewScanner(os.Stdin)
	result := map[string]string{}
	for scanner.Scan() {
		found := processLine(scanner.Text())
		for _, word := range found {
			result[word] = searchInternalDB(internaldb, word)
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
	for key, out := range result {
		if out != "" {
			fmt.Printf("%s %s\n", key, out)
		}
	}
}
