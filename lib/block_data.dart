import 'package:flutter/material.dart';

Map blocks = {
    'I': {
        'color': Colors.blue[300],
        'tiles':
            [ [ [ 1, 0, 0, 0 ],
                [ 1, 0, 0, 0 ],
                [ 1, 0, 0, 0 ],
                [ 1, 0, 0, 0 ] ],
              
              [ [ 0, 0, 0, 0 ],
                [ 0, 0, 0, 0 ],
                [ 0, 0, 0, 0 ],
                [ 1, 1, 1, 1 ] ] ]
    },
    'J': {
        'color': Colors.blue[900],
        'tiles':
            [ [ [ 0, 1, 0 ],
                [ 0, 1, 0 ],
                [ 1, 1, 0 ] ],
              
              [ [ 0, 0, 0 ],
                [ 1, 1, 1 ],
                [ 0, 0, 1 ] ],
              
              [ [ 1, 1, 0 ],
                [ 1, 0, 0 ],
                [ 1, 0, 0 ] ],
              
              [ [ 0, 0, 0 ],
                [ 1, 0, 0 ],
                [ 1, 1, 1 ] ] ]
    },
    'L': {
        'color': Colors.amber[100],
        'tiles':
            [ [ [ 1, 0, 0 ],
                [ 1, 0, 0 ],
                [ 1, 1, 0 ] ],
              
              [ [ 0, 0, 0 ],
                [ 0, 0, 1 ],
                [ 1, 1, 1 ] ],
              
              [ [ 0, 1, 1 ],
                [ 0, 0, 1 ],
                [ 0, 0, 1 ] ],
              
              [ [ 0, 0, 0 ],
                [ 1, 1, 1 ],
                [ 1, 0, 0 ] ] ]
    },
    'S': {
        'color': Colors.red[400],
        'tiles':
            [ [ [ 0, 0, 0 ],
                [ 0, 1, 1 ],
                [ 1, 1, 0 ] ],
              
              [ [ 1, 0, 0 ],
                [ 1, 1, 0 ],
                [ 0, 1, 0 ] ] ]
    },
    'Z': {
        'color': Colors.green[400],
        'tiles':
            [ [ [ 0, 0, 0 ],
                [ 1, 1, 0 ],
                [ 0, 1, 1 ] ],
              
              [ [ 0, 1, 0 ],
                [ 1, 1, 0 ],
                [ 1, 0, 0 ] ] ]
    },
    'O': {
        'color': Colors.yellow,
        'tiles': [ [ [ 1, 1 ],
                     [ 1, 1 ] ] ]
    },
    'T': {
        'color': Colors.purple[300],
        'tiles':
            [ [ [ 0, 0, 0 ],
                [ 0, 1, 0 ],
                [ 1, 1, 1 ] ],
              
              [ [ 0, 1, 0 ],
                [ 1, 1, 0 ],
                [ 0, 1, 0 ] ],
              
              [ [ 0, 0, 0 ],
                [ 1, 1, 1 ],
                [ 0, 1, 0 ] ],
              
              [ [ 1, 0, 0 ],
                [ 1, 1, 0 ],
                [ 1, 0, 0 ] ] ]
    }
};


class Block {
  final String type;
  int orientation;
  int row;
  int col;
  Block(this.type);
}