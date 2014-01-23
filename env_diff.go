package main

import (
	"strings"
)

// A list of keys we don't want to deal with
var IGNORED_KEYS = map[string]bool{
	// direnv env config
	"DIRENV_CONFIG": true,
	"DIRENV_BASH":   true,

	"COMP_WORDBREAKS": true, // Avoids segfaults in bash
	"PS1":             true, // PS1 should not be exported, fixes problem in bash

	// variables that should change freely
	"OLDPWD": true,
	"PWD":    true,
	"SHELL":  true,
	"SHLVL":  true,
	"_":      true,
}

type EnvDiff struct {
	Prev map[string]string `json:"p"`
	Next map[string]string `json:"n"`
}

func BuildEnvDiff(e1, e2 Env) *EnvDiff {
	diff := &EnvDiff{make(map[string]string), make(map[string]string)}

	for key := range e1 {
		if e2[key] != e1[key] && !IgnoredEnv(key) {
			diff.Prev[key] = e1[key]
		}
	}

	for key := range e2 {
		if e2[key] != e1[key] && !IgnoredEnv(key) {
			diff.Next[key] = e2[key]
		}
	}

	return diff
}

func LoadEnvDiff(base64env string) (diff *EnvDiff, err error) {
	diff = new(EnvDiff)
	err = unmarshal(base64env, diff)
	return
}

func (self *EnvDiff) Any() bool {
	return len(self.Prev) > 0 || len(self.Next) > 0
}

func (self *EnvDiff) ToShell(shell Shell) string {
	str := ""

	for key := range self.Prev {
		_, ok := self.Next[key]
		if !ok {
			str += shell.Unset(key)
		}
	}

	for key, value := range self.Next {
		str += shell.Export(key, value)
	}

	return str
}

func (self *EnvDiff) Patch(env Env) (newEnv Env) {
	newEnv = make(Env)

	for k, v := range env {
		newEnv[k] = v
	}

	for key := range self.Prev {
		delete(newEnv, key)
	}

	for key, value := range self.Next {
		newEnv[key] = value
	}

	return newEnv
}

func (self *EnvDiff) Reverse() *EnvDiff {
	return &EnvDiff{self.Next, self.Prev}
}

func (self *EnvDiff) Serialize() string {
	return marshal(self)
}

//// Utils

func IgnoredEnv(key string) bool {
	if strings.HasPrefix(key, "__fish") {
		return true
	}
	_, found := IGNORED_KEYS[key]
	return found
}
