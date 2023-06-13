//
// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package config

import (
	"fmt"
)

type Distro int64

const (
	DEBIAN10 Distro = iota
	DEBIAN11
	DEBIAN12
)

var distros = []Distro{DEBIAN10, DEBIAN11, DEBIAN12}

func (d Distro) String() string {
	switch d {
	case DEBIAN10:
		return "debian10"
	case DEBIAN11:
		return "debian11"
	case DEBIAN12:
		return "debian12"
	}

	panic("unknown release")
}

func (d Distro) Version() int {
	switch d {
	//nolint:gomnd // Debian versions are not going to change
	case DEBIAN10:
		return 10
	//nolint:gomnd // Debian versions are not going to change
	case DEBIAN11:
		return 11
	//nolint:gomnd // Debian versions are not going to change
	case DEBIAN12:
		return 12
	}

	panic("unknown release")
}

func (d Distro) Codename() string {
	switch d {
	case DEBIAN10:
		return "buster"
	case DEBIAN11:
		return "bullseye"
	case DEBIAN12:
		return "bookworm"
	}

	panic("unknown release")
}

func (d *Distro) UnmarshalYAML(unmarshal func(interface{}) error) error {
	var s string

	if err := unmarshal(&s); err != nil {
		return err
	}

	for _, distro := range distros {
		if s == distro.String() {
			*d = distro
			return nil
		}
	}

	return fmt.Errorf("%q is not a valid distro", s)
}

func DistroFromString(s string) (Distro, error) {
	for _, distro := range distros {
		if s == distro.String() {
			return distro, nil
		}
	}

	return -1, fmt.Errorf("%q is not a valid distro", s)
}
