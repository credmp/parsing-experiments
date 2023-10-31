module bide

import IO;
import lang::json::IO;

data LabelType
  = property()
  | attribute()
  ;

data Shape
  = shape(Shape shape, list[Shape] children)
  | shape(Shape shape)
  | label(LabelType \type, Shape content)
  | text(str text)
  | name(str name)
  | rectangle()
  | circle()
  | triangle()
  | propertyLabel()
  | attributeLabel()
  ;

data NodeType
  = terminal()
  | nonterminal()
  ;

data Description = description(map[str, Shape] shapes);

// Node Properties
// Node Attributes

data NodeId = nodeId(str id);
data Node = \node(NodeType \type, NodeId id, str name);

// TODO: define a vertex style
data Vertex = vertex(NodeId from, NodeId to);

data Definition = definition(list[Node] nodes, list[Vertex] vertexes);

// TODO define rascal functions that act as transformers
// From a ParseTree to a BiDE Node definition and from a
// BiDE Node definition to a visual representation -- given the nature of
// the definitions, a visualization strategy might not be needed

data BiDE = bide(Description description, Definition definition);


void printJSON() {
  // create a rectangle with a label, below that a rectangle with a list of labels with method names
  // Shape erd = shape(rectangle(), [shape(label(), [propertyLabel(text("name"))]), shape(rectangle(), [shape(label(attributeLabel()),[attributeLabel(text("method"))])])]);
  // // a simple state diagram node
  // Shape state = shape(circle(), [shape(label(),[propertyLabel(text("name"))])]);

  // Rectangle with a property label
  Shape title = shape(rectangle(), [shape(label(property(), name("class")))]);
  // A rectangle with a label for the attribute "method", multiple methods? The shape will be iterated
  Shape methods = shape(rectangle(), [shape(label(attribute(), name("method")))]);
  Shape erd = shape(rectangle(), [title, methods]);
  Description desc = description(("terminal":erd,"nonterminal":erd));

  Node n1 = \node(terminal(), nodeId("id1"), "nodething 1");
  Node n2 = \node(nonterminal(),nodeId("id2"), "nodething 2");

  Vertex v = vertex(n1.id, n2.id);

  Definition def = definition([n1,n2], [v]);

  BiDE b = bide(desc,def);

  println(asJSON(b, indent=2));
}
