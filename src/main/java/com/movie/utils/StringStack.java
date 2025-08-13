package com.movie.utils;
import java.util.ArrayList;
import java.util.List;


public class StringStack {
    private int maxSize;     // Maximum size of the stack
    private String[] stackArray; // Array to hold movie titles
    private int top;         // Index of the top element

    // Constructor to initialize the stack with a fixed size
    public StringStack(int size) {
        maxSize = size;
        stackArray = new String[maxSize];
        top = -1; // Empty stack initially
    }

    // Push a movie title onto the stack
    public void push(String title) {
        if (isFull()) {
            System.out.println("Stack is full. Cannot add: " + title);
            return;
        }
        stackArray[++top] = title; // Increment top, then insert
    }

    // Pop the top movie title from the stack
    public String pop() {
        if (isEmpty()) {
            System.out.println("Stack is empty. Cannot pop.");
            return null;
        }
        return stackArray[top--]; // Return top item, then decrement
    }

    // Peek at the top movie title without removing it
    public String peek() {
        if (isEmpty()) {
            System.out.println("Stack is empty. Nothing to peek.");
            return null;
        }
        return stackArray[top];
    }

    // Check if the stack is empty
    public boolean isEmpty() {
        return (top == -1);
    }

    // Check if the stack is full
    public boolean isFull() {
        return (top == maxSize - 1);
    }

    // Get the current number of items in the stack
    public int size() {
        return top + 1;
    }
    // New method to get elements as a list (bottom to top)
    public List<String> toList() {
        List<String> list = new ArrayList<>();
        for (int i = 0; i <= top; i++) {
            list.add(stackArray[i]);
        }
        return list;
    }
}