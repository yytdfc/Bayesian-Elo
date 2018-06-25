#!/usr/bin/env python
# encoding: utf-8

if __name__=='__main__':
    import bayeselo
    r = bayeselo.ResultSet()
    r.append(1, 0, 2)
    e = bayeselo.EloRating(r, ['1', '2'])
    e.offset(1600)
    e.mm()
    e.exact_dist()
    print(e)

