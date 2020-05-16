def update_raw(alfred=False, rtdsm=False, spf=False, greenbook=False, specific_variables=[]):

    import requests, time, zipfile, io
    timeout = 10

    # update ALFRED data

    # update RTDSM data
    if rtdsm == True or len(specific_variables) > 0:

        print('Downloading RTDSM data ......')

        rtdsm_url = 'https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/real-time-data/data-files/files/xlsx/'
        rtdsm_names = [

            # quarterly observation, monthly vintage
            'routputmvqd', # Real GDP
            'rconmvqd', # Real consumption: total
            'rconndmvqd', # Real consumption: non-durables
            'rcondmvqd', # Real consumption: durables
            'rconsmvqd', # Real consumption: services
            'rinvbfmvqd', # Real investment: non-residential
            'rinvresidmvqd', # Real investment: residential
            'rinvchimvqd', # Real investment: change in private inventories
            'rnxmvqd', # Real net exports
            'rgmvqd', # Real govt cons & invest: total
            'rgfmvqd', # Real govt cons & invest: federal
            'rgslmvqd', # Real govt cons & invest: state and local
            'pmvqd', # GDP deflator

            # monthly observation, monthly vintage
            'rconmmvmd', # Real consumption: total
            'rconndmmvmd', # Real consumption: non-durables
            'rcondmmvmd', # Real consumption: durables
            'rconsmmvmd', # Real consumption: services
            'pcpimvmd', # CPI
            'popmvmd', # Civilian population 16+
            'employmvmd', # Nonfarm payroll employment
            'hmvmd', # Average weekly hours

            # monthly observation, quarterly vintage
            'rucqvmd', # Unemployment rate

        ]

        for name in rtdsm_names:

            if len(specific_variables) == 0 or name in specific_variables:

                print(name + ' ...', end=' ')

                filename = name + '.xlsx'
                url = rtdsm_url + filename

                time.sleep(10)
                page = requests.get(url, timeout=timeout)

                if page.status_code == 200:
                    with open('rtdsm/' + filename, 'wb') as f:
                        f.write(page.content)
                    print('complete')
                else:
                    print('failed, try again ...', end=' ')
                    time.sleep(10)
                    page = requests.get(url, timeout=timeout)
                    if page.status_code == 200:
                        with open('rtdsm/' + filename, 'wb') as f:
                            f.write(page.content)
                        print('complete')
                    else:
                        print('failed!')

    # update SPF data
    if spf == True or len(specific_variables) > 0:

        print('Downloading SPF data ......')

        spf_url = 'https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/data-files/files/'
        spf_names = [

            # all quarterly osbervation, individual forecasts

            'individual_pgdp', # GDP deflator
            'individual_unemp', # Unemployment rate
            'individual_emp', # Nonfarm payroll employment

            'individual_baabond', # Moody's BAA corporate bond yield
            'individual_tbond', # 10 yr Treasury bond yield

            'individual_rgdp', # Real GDP
            'individual_rconsum', # Real consumption
            'individual_rnresin', # Real investment: non-residential
            'individual_rresinv', # Real investment: residential
            'individual_rcbi', # Real investment: change in private inventories
            'individual_rfedgov', # Real govt cons & invest: federal
            'individual_rslgov', # Real govt cons & invest: state and local
            'individual_rexport', # Real net exports
            'individual_cpi', # CPI

        ]

        for name in spf_names:

            if len(specific_variables) == 0 or name in specific_variables:

                print(name + ' ...', end=' ')

                filename = name + '.xlsx'
                url = spf_url + filename

                time.sleep(10)
                page = requests.get(url, timeout=timeout)

                if page.status_code == 200:
                    with open('spf/' + filename, 'wb') as f:
                        f.write(page.content)
                    print('complete')
                else:
                    print('failed, try again ...', end=' ')
                    time.sleep(10)
                    page = requests.get(url, timeout=timeout)
                    if page.status_code == 200:
                        with open('spf/' + filename, 'wb') as f:
                            f.write(page.content)
                        print('complete')
                    else:
                        print('failed!')

    # update Greenbook data
    if greenbook == True:

        print('Downloading Greenbook data ......')

        url = 'https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/greenbook-data/gbweb/gbweb_all_column_format.zip?la=en'
        time.sleep(10)
        page = requests.get(url, timeout=timeout)

        if page.status_code == 200:
            z = zipfile.ZipFile(io.BytesIO(page.content))
            z.extractall(path='greenbook/')
            print('complete')
        else:
            print('failed, try again ...', end=' ')
            time.sleep(10)
            page = requests.get(url, timeout=timeout)
            if page.status_code == 200:
                z = zipfile.ZipFile(io.BytesIO(page.content))
                z.extractall(path='greenbook/')
                print('complete')
            else:
                print('failed!')


if __name__ == '__main__':
    data_update()