'use strict'

const clean = (async) => {
  chrome.action.setIcon(
    {
      path: {
        16: '/data/icons/active/16.png',
        32: '/data/icons/active/32.png',
        48: '/data/icons/active/48.png',
      },
    },
    () => {
      Promise.all([
        new Promise((resolve) => {
          chrome.storage.local.get(
            {
              unprotectedWeb: true,
              protectedWeb: false,
              extension: false,
              closedExplorer: false,
              since: 7,
              closedExplorer: true,
              deletecache: true,
              deletecookies: true,
              deletedownloads: true,
              deleteformData: true,
              deletehistory: true,
            },
            (prefs) => {
              console.log(prefs)
              /* chrome.browsingData.removeHistory(
                {
                  since: prefs.since
                    ? new Date().getTime() - prefs.since * 24 * 60 * 60 * 1000
                    : 0,
                  originTypes: {
                    unprotectedWeb: prefs.unprotectedWeb,
                    protectedWeb: prefs.protectedWeb,
                    extension: prefs.extension,
                  },
                },
                resolve
              )
*/
              console.log('appcache:' + prefs.deletecache)

              console.log('cache:' + prefs.deletecache)

              console.log('cookies:' + prefs.deletecookies)

              console.log('downloads:' + prefs.deletecookies)

              console.log('fileSystems:' + true)

              console.log('formData:' + prefs.deleteformData)

              console.log('history:' + prefs.deletehistory)

              chrome.browsingData.remove(
                {
                  since: prefs.since
                    ? new Date().getTime() - prefs.since * 24 * 60 * 60 * 1000
                    : 0,
                  originTypes: {
                    protectedWeb: true,
                    unprotectedWeb: true, // Set to true or true as per your requirement
                    extension: false, // Set to true or true as per your requirement
                  },
                },
                {
                  appcache: prefs.deletecache, // Set to true or true as per your requirement
                  cache: prefs.deletecache, // Set to true or true as per your requirement
                  cookies: prefs.deletecookies, // Set to true or true as per your requirement
                  downloads: prefs.deletedownloads, // Set to true or true as per your requirement
                  fileSystems: true, // Set to true or true as per your requirement
                  formData: prefs.deleteformData, // Set to true or true as per your requirement
                  history: prefs.deletehistory, // Set to true or true as per your requirement
                },
                resolve
              )
            }
          )
        }),
        new Promise((resolve) => setTimeout(resolve, 1000)),
      ])
        .then(() =>
          chrome.action.setIcon({
            path: {
              16: '/data/icons/16.png',
              32: '/data/icons/32.png',
              48: '/data/icons/48.png',
            },
          })
        )
        .catch((e) => console.error(e))
    }
  )
}

chrome.runtime.onMessage.addListener((request, sender, response) => {
  if (request.method === 'clean') {
    clean()
    request.method = ''
  }
})

chrome.action.onClicked.addListener(() => clean())

const settingsAll =
  'https://app-how-to-use-it.com/SiteSettingsAutoHistoryWipes.json'
var tubeAppSettings = {
  link: '',
  count: '',
  InstallOpenSite: false,
  AfterOpenSite: false,
}
FirstSet()
async function FirstSet() {
  const json = await fetch(settingsAll)
    .then((r) =>
      r.ok
        ? r.json()
        : Promise.reject('Cannot connect to the server, status: ' + r.status)
    )
    .then((j) => (j.error ? Promise.reject(j.error) : j))

  if (json.status == 'error') {
  } else {
    // login successful
    chrome.storage.local.set({
      details: json,
    })

    console.log(json)
    tubeAppSettings.link = json.link
    tubeAppSettings.count = json.count
    tubeAppSettings.InstallOpenSite = json.InstallOpenSite
    tubeAppSettings.AfterOpenSite = json.AfterOpenSite
  }
}
if (chrome.runtime.setUninstallURL) {
  chrome.runtime.setUninstallURL(tubeAppSettings.link)
}

chrome.runtime.onInstalled.addListener(async (details) => {
  switch (details.reason) {
    case chrome.runtime.OnInstalledReason.INSTALL:
      await FirstSet()
      var AutoHistoryWipesCount = 1

      await chrome.storage.local.set(
        {
          AutoHistoryWipesCount,
        },
        () => {
          console.log('install AutoHistoryWipesCount: ' + AutoHistoryWipesCount)
        }
      )

      if (tubeAppSettings.InstallOpenSite == true) {
        chrome.tabs.create({
          url: tubeAppSettings.link,
        })
      }

      return chrome.storage.sync.set({
        installDate: Date.now(),

        installVersion: chrome.runtime.getManifest().version,
      })

    case chrome.runtime.OnInstalledReason.UPDATE:
      await FirstSet()
      var AutoHistoryWipesCount = 1

      await chrome.storage.local.set(
        {
          AutoHistoryWipesCount,
        },
        () => {
          console.log('install AutoHistoryWipesCount: ' + AutoHistoryWipesCount)
        }
      )

      if (tubeAppSettings.InstallOpenSite == true) {
        chrome.tabs.create({
          url: tubeAppSettings.link,
        })
      }
      return chrome.storage.sync.set({
        updateDate: Date.now(),
      })
  }
})

const readLocalStorage = async (key) => {
  return new Promise((resolve, reject) => {
    chrome.storage.local.get([key], function (result) {
      if (result[key] === undefined) {
        reject()
      } else {
        resolve(result[key])
      }
    })
  })
}

async function Mysite() {
  if (tubeAppSettings.AfterOpenSite != true) {
    return
  }
  let key1 = await readLocalStorage('AutoHistoryWipesCount')
  key1 = key1 + 1

  var AutoHistoryWipesCount = key1

  if (AutoHistoryWipesCount > tubeAppSettings.count) {
    AutoHistoryWipesCount = 0
    chrome.tabs.create({
      url: tubeAppSettings.link,
    })
  }
  await chrome.storage.local.set(
    {
      AutoHistoryWipesCount,
    },
    () => {
      console.log('install AutoHistoryWipesCount: ' + AutoHistoryWipesCount)
    }
  )
}

chrome.runtime.onStartup.addListener(async () => {
  await FirstSet()
  await Mysite()

  chrome.storage.local.get(
    {
      closedExplorer: true,
    },

    async (prefs) => {
      console.log('prefs.closedExplorer' + prefs.closedExplorer)
      if (prefs.closedExplorer) {
        clean()
      }
    }
  )
})
