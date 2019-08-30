package opengl

import (
	"github.com/dianelooney/gggv/internal/errors"
)

type SourceKind string

type SourceName string

type Source interface {
	Kind() SourceKind
	Name() SourceName
	Children() []SourceName
	Render(scene *Scene)
	Texture() uint32
}

func Order(target SourceName, sources map[SourceName]Source) (order []SourceName, err error) {
	s := sorter{
		sources:  sources,
		ordered:  make(map[SourceName]bool, len(sources)),
		ordering: nil,
	}
	err = s.order(target, 0)
	order = s.ordering
	return
}

type sorter struct {
	sources  map[SourceName]Source
	ordered  map[SourceName]bool
	ordering []SourceName
}

func (s *sorter) order(name SourceName, depth int) (err error) {
	if depth > len(s.sources) {
		return errors.SourceDependencyLoop()
	}

	if s.ordered[name] {
		return nil
	}

	this := s.sources[name]
	if this == nil {
		return errors.SourceMissing(name)
	}
	for _, child := range s.sources[name].Children() {
		s.order(child, depth+1)
	}
	s.ordered[name] = true
	s.ordering = append(s.ordering, name)

	return nil
}
