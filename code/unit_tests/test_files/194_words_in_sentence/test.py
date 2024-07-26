# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(sentence):
    result = ""
    current = ""
    for i in range(len(sentence) + 1):
        if i == len(sentence) or sentence[i] == ' ':
            is_prime = True
            l = len(current)
            if l < 2:
                is_prime = False
            for j in range(2, l):
                if l % j == 0:
                    is_prime = False
                    break
            if is_prime:
                result += current + ' '
            current = ""
        else:
            current += sentence[i]
    if len(result) > 0:
        result = result[:-1]
    return result

# End here


def serialize_list(obj) -> str:
    list_str = ["["]
    for item in obj:
        list_str.append(serialize_obj(item))
        list_str.append(",")
    list_str[-1] = "]"
    return "".join(list_str)


def serialize_dict(obj) -> str:
    m = OrderedDict(sorted(obj.items()))
    dict_str = ["{"]
    for key, value in m.items():
        dict_str.append(serialize_obj(key))
        dict_str.append(":")
        dict_str.append(serialize_obj(value))
        dict_str.append(",")
    dict_str[-1] = "}"
    return "".join(dict_str)


def serialize_obj(obj) -> str:
    if obj is None:
        return "null"
    if isinstance(obj, int) or isinstance(obj, float):
        return "{0:.6f}".format(obj)
    if isinstance(obj, str):
        return '"' + obj + '"'
    if isinstance(obj, bool):
        return str(obj)
    if isinstance(obj, list):
        return serialize_list(obj)
    if isinstance(obj, dict):
        return serialize_dict(obj)
    raise Exception("Unrecognized Type!")


def are_equivalent(o1, o2) -> bool:
    print(serialize_obj(o1)+" "+serialize_obj(o2))
    return serialize_obj(o1) == serialize_obj(o2)


def start():
    ret = False
    count = 0
    total = 0
    # Write the unit tests here
    total += 1
    ret = are_equivalent(testfunc("This is a test"),"is")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("lets go for swimming"),"go for")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("there is no place available here"),"there is no place")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("Hi I am Hussein"),"Hi am Hussein")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("go for it"),"go for it")
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
