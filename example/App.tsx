import React, {useEffect, useRef, useState} from 'react';
import {
  Alert,
  Platform,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  TurboModuleRegistry,
  View,
} from 'react-native';
import {YMChat, YMChatEvents} from 'ymchat-react-native';

// ─── Constants ───────────────────────────────────────────────────────────────
// Replace with your bot ID and API key before testing
const DEFAULT_BOT_ID = 'x1657623696077';
const DEFAULT_API_KEY = 'YOUR_API_KEY';
const DEFAULT_DEVICE_TOKEN = 'DEVICE_PUSH_TOKEN';

// ─── Types ────────────────────────────────────────────────────────────────────
type LogEntry = {id: number; time: string; tag: string; msg: string};

// ─── Helpers ─────────────────────────────────────────────────────────────────
// iOS New Arch registers under 'YMChatReactNative' to avoid SDK class name clash
const isNewArch =
  TurboModuleRegistry != null &&
  TurboModuleRegistry.get != null &&
  (TurboModuleRegistry.get('YMChatReactNative') ?? TurboModuleRegistry.get('YMChat')) != null;

let logId = 0;
function makeEntry(tag: string, msg: string): LogEntry {
  const now = new Date();
  const time = `${now.getHours().toString().padStart(2, '0')}:${now
    .getMinutes()
    .toString()
    .padStart(2, '0')}:${now.getSeconds().toString().padStart(2, '0')}`;
  return {id: ++logId, time, tag, msg};
}

// ─── App ─────────────────────────────────────────────────────────────────────
export default function App() {
  const [botId, setBotId] = useState(DEFAULT_BOT_ID);
  const [apiKey, setApiKey] = useState(DEFAULT_API_KEY);
  const [deviceToken, setDeviceToken] = useState(DEFAULT_DEVICE_TOKEN);
  const [logs, setLogs] = useState<LogEntry[]>([]);
  const scrollRef = useRef<ScrollView>(null);

  const log = (tag: string, msg: string) => {
    setLogs(prev => {
      const updated = [...prev, makeEntry(tag, msg)];
      return updated.slice(-100); // keep last 100 entries
    });
    setTimeout(() => scrollRef.current?.scrollToEnd({animated: true}), 50);
  };

  // ── Event listeners ──────────────────────────────────────────────────────
  useEffect(() => {
    if (!YMChatEvents) {
      return;
    }
    const onChatEvent = YMChatEvents.addListener('YMChatEvent', event => {
      log('EVENT', `YMChatEvent → code=${event?.code}  data=${JSON.stringify(event?.data ?? null)}`);
    });
    const onBotClose = YMChatEvents.addListener('YMBotCloseEvent', () => {
      log('EVENT', 'YMBotCloseEvent — bot was closed');
    });
    const onBotLoadFailed = YMChatEvents.addListener('YMBotLoadFailedEvent', () => {
      log('EVENT', 'YMBotLoadFailedEvent — bot failed to load');
    });
    return () => {
      onChatEvent.remove();
      onBotClose.remove();
      onBotLoadFailed.remove();
    };
  }, []);

  // ── SDK actions ──────────────────────────────────────────────────────────
  const initBot = () => {
    try {
      YMChat.setBotId(botId);
      log('CONFIG', `setBotId("${botId}")`);
    } catch (e: any) {
      log('ERROR', `setBotId failed: ${e.message}`);
    }
  };

  const configureAndStart = () => {
    try {
      YMChat.setBotId(botId);
      YMChat.setAuthenticationToken('test-auth-token');
      YMChat.setCustomURL('https://app.yellowmessenger.com');
      YMChat.showCloseButton(true);
      YMChat.setDisableActionsOnLoad(false);
      YMChat.setVersion(2);
      YMChat.setPayload({source: 'rn-example', platform: Platform.OS});
      YMChat.setThemePrimaryColor('#3B82F6');
      YMChat.setThemeSecondaryColor('#1D4ED8');
      YMChat.setThemeBotName('YMChat Bot');
      YMChat.setThemeBotDescription('Powered by Yellow.ai');
      log('CONFIG', 'Full configuration applied');

      YMChat.startChatbot();
      log('LIFECYCLE', 'startChatbot() called');
    } catch (e: any) {
      log('ERROR', `configureAndStart failed: ${e.message}`);
    }
  };

  const startBot = () => {
    try {
      if (!botId || botId === 'YOUR_BOT_ID') {
        Alert.alert('Missing Bot ID', 'Set a valid Bot ID before starting.');
        return;
      }
      YMChat.setBotId(botId);
      YMChat.startChatbot();
      log('LIFECYCLE', 'startChatbot() called');
    } catch (e: any) {
      log('ERROR', `startChatbot failed: ${e.message}`);
    }
  };

  const closeBot = () => {
    try {
      YMChat.closeBot();
      log('LIFECYCLE', 'closeBot() called');
    } catch (e: any) {
      log('ERROR', `closeBot failed: ${e.message}`);
    }
  };

  const reloadBot = () => {
    try {
      YMChat.reloadBot();
      log('LIFECYCLE', 'reloadBot() called');
    } catch (e: any) {
      log('ERROR', `reloadBot failed: ${e.message}`);
    }
  };

  const revalidateToken = () => {
    try {
      YMChat.revalidateToken('new-token-value', true);
      log('AUTH', 'revalidateToken("new-token-value", refreshSession=true)');
    } catch (e: any) {
      log('ERROR', `revalidateToken failed: ${e.message}`);
    }
  };

  const sendEvent = () => {
    try {
      YMChat.sendEventToBot('test-event', {key: 'value', from: 'rn-example'});
      log('EVENT', 'sendEventToBot("test-event", {...}) called');
    } catch (e: any) {
      log('ERROR', `sendEventToBot failed: ${e.message}`);
    }
  };

  const registerDevice = async () => {
    try {
      log('ASYNC', 'registerDevice() → awaiting…');
      const result = await YMChat.registerDevice(apiKey);
      log('ASYNC', `registerDevice() resolved → ${result}`);
    } catch (e: any) {
      log('ERROR', `registerDevice rejected → ${e.message ?? e}`);
    }
  };

  const unlinkDevice = async () => {
    try {
      log('ASYNC', 'unlinkDeviceToken() → awaiting…');
      const result = await YMChat.unlinkDeviceToken(botId, apiKey, deviceToken);
      log('ASYNC', `unlinkDeviceToken() resolved → ${result}`);
    } catch (e: any) {
      log('ERROR', `unlinkDeviceToken rejected → ${e.message ?? e}`);
    }
  };

  const getUnreadCount = async () => {
    try {
      log('ASYNC', 'getUnreadMessagesCount() → awaiting…');
      const count = await YMChat.getUnreadMessagesCount();
      log('ASYNC', `getUnreadMessagesCount() resolved → ${count}`);
    } catch (e: any) {
      log('ERROR', `getUnreadMessagesCount rejected → ${e.message ?? e}`);
    }
  };

  const testSpeech = () => {
    try {
      YMChat.setEnableSpeech(true);
      YMChat.setMicButtonMovable(true);
      YMChat.setMicIconColor('#FFFFFF');
      YMChat.setMicBackgroundColor('#3B82F6');
      log('CONFIG', 'Speech config applied (enableSpeech=true)');
    } catch (e: any) {
      log('ERROR', `speech config failed: ${e.message}`);
    }
  };

  const testTheme = () => {
    try {
      YMChat.setThemePrimaryColor('#7C3AED');
      YMChat.setThemeSecondaryColor('#5B21B6');
      YMChat.setThemeBotBubbleBackgroundColor('#EDE9FE');
      YMChat.setThemeBotName('Purple Bot');
      YMChat.setThemeBotDescription('Themed example');
      YMChat.setThemeLinkColor('#7C3AED');
      YMChat.setChatContainerTheme('dark');
      log('THEME', 'Purple theme applied');
    } catch (e: any) {
      log('ERROR', `theme config failed: ${e.message}`);
    }
  };

  const clearLogs = () => setLogs([]);

  // ── Render ───────────────────────────────────────────────────────────────
  return (
    <SafeAreaView style={styles.root}>
      <StatusBar barStyle="light-content" backgroundColor="#1E3A5F" />

      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>YMChat SDK Test</Text>
        <View style={[styles.archBadge, isNewArch ? styles.newArch : styles.oldArch]}>
          <Text style={styles.archText}>
            {isNewArch ? '✓ New Architecture' : '⚠ Old Architecture'}
          </Text>
        </View>
      </View>

      <ScrollView style={styles.scroll} contentContainerStyle={styles.scrollContent}>

        {/* Inputs */}
        <Section title="Configuration">
          <Label>Bot ID</Label>
          <TextInput
            style={styles.input}
            value={botId}
            onChangeText={setBotId}
            placeholder="your-bot-id"
            placeholderTextColor="#94A3B8"
            autoCapitalize="none"
          />
          <Label>API Key</Label>
          <TextInput
            style={styles.input}
            value={apiKey}
            onChangeText={setApiKey}
            placeholder="your-api-key"
            placeholderTextColor="#94A3B8"
            autoCapitalize="none"
          />
          <Label>Device Token (for push)</Label>
          <TextInput
            style={styles.input}
            value={deviceToken}
            onChangeText={setDeviceToken}
            placeholder="FCM/APNs device token"
            placeholderTextColor="#94A3B8"
            autoCapitalize="none"
          />
          <Btn label="setBotId" color="#3B82F6" onPress={initBot} />
          <Btn label="Full configure + startChatbot" color="#059669" onPress={configureAndStart} />
        </Section>

        {/* Lifecycle */}
        <Section title="Lifecycle">
          <Row>
            <Btn label="startChatbot" color="#2563EB" onPress={startBot} flex />
            <Btn label="closeBot" color="#DC2626" onPress={closeBot} flex />
          </Row>
          <Row>
            <Btn label="reloadBot" color="#7C3AED" onPress={reloadBot} flex />
            <Btn label="revalidateToken" color="#D97706" onPress={revalidateToken} flex />
          </Row>
          <Btn label="sendEventToBot" color="#0891B2" onPress={sendEvent} />
        </Section>

        {/* Async APIs */}
        <Section title="Async APIs (Promises)">
          <Btn label="registerDevice → Promise" color="#4F46E5" onPress={registerDevice} />
          <Btn label="getUnreadMessagesCount → Promise" color="#4F46E5" onPress={getUnreadCount} />
          <Btn label="unlinkDeviceToken → Promise" color="#4F46E5" onPress={unlinkDevice} />
        </Section>

        {/* Feature configs */}
        <Section title="Feature Config">
          <Row>
            <Btn label="Speech config" color="#0369A1" onPress={testSpeech} flex />
            <Btn label="Purple theme" color="#7C3AED" onPress={testTheme} flex />
          </Row>
        </Section>

        {/* Event Log */}
        <Section title={`Event Log (${logs.length})`} noPad>
          <View style={styles.logHeader}>
            <Text style={styles.logHint}>Events and API responses appear here</Text>
            <TouchableOpacity onPress={clearLogs}>
              <Text style={styles.clearBtn}>Clear</Text>
            </TouchableOpacity>
          </View>
          <ScrollView
            ref={scrollRef}
            style={styles.logBox}
            nestedScrollEnabled
            showsVerticalScrollIndicator>
            {logs.length === 0 ? (
              <Text style={styles.logEmpty}>No logs yet. Tap an action above.</Text>
            ) : (
              logs.map(entry => (
                <View key={entry.id} style={styles.logRow}>
                  <Text style={styles.logTime}>{entry.time}</Text>
                  <Text style={[styles.logTag, tagStyle(entry.tag)]}>{entry.tag}</Text>
                  <Text style={styles.logMsg}>{entry.msg}</Text>
                </View>
              ))
            )}
          </ScrollView>
        </Section>

      </ScrollView>
    </SafeAreaView>
  );
}

// ─── Sub-components ──────────────────────────────────────────────────────────
function Section({
  title,
  children,
  noPad,
}: {
  title: string;
  children: React.ReactNode;
  noPad?: boolean;
}) {
  return (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>{title}</Text>
      <View style={noPad ? undefined : styles.sectionBody}>{children}</View>
    </View>
  );
}

function Label({children}: {children: string}) {
  return <Text style={styles.label}>{children}</Text>;
}

function Row({children}: {children: React.ReactNode}) {
  return <View style={styles.row}>{children}</View>;
}

function Btn({
  label,
  color,
  onPress,
  flex,
}: {
  label: string;
  color: string;
  onPress: () => void;
  flex?: boolean;
}) {
  return (
    <TouchableOpacity
      style={[styles.btn, {backgroundColor: color}, flex && styles.btnFlex]}
      onPress={onPress}
      activeOpacity={0.75}>
      <Text style={styles.btnText}>{label}</Text>
    </TouchableOpacity>
  );
}

function tagStyle(tag: string) {
  const map: Record<string, object> = {
    EVENT: {color: '#34D399'},
    CONFIG: {color: '#60A5FA'},
    LIFECYCLE: {color: '#A78BFA'},
    ASYNC: {color: '#FBBF24'},
    AUTH: {color: '#F472B6'},
    THEME: {color: '#C084FC'},
    ERROR: {color: '#F87171'},
  };
  return map[tag] ?? {color: '#94A3B8'};
}

// ─── Styles ───────────────────────────────────────────────────────────────────
const styles = StyleSheet.create({
  root: {flex: 1, backgroundColor: '#0F172A'},
  header: {
    backgroundColor: '#1E3A5F',
    paddingHorizontal: 16,
    paddingVertical: 12,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  headerTitle: {color: '#F1F5F9', fontSize: 18, fontWeight: '700'},
  archBadge: {paddingHorizontal: 10, paddingVertical: 4, borderRadius: 12},
  newArch: {backgroundColor: '#064E3B'},
  oldArch: {backgroundColor: '#7C2D12'},
  archText: {color: '#F1F5F9', fontSize: 11, fontWeight: '600'},
  scroll: {flex: 1},
  scrollContent: {padding: 12, gap: 12},
  section: {
    backgroundColor: '#1E293B',
    borderRadius: 12,
    overflow: 'hidden',
    marginBottom: 4,
  },
  sectionTitle: {
    color: '#94A3B8',
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 1,
    textTransform: 'uppercase',
    paddingHorizontal: 14,
    paddingTop: 12,
    paddingBottom: 8,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#334155',
  },
  sectionBody: {padding: 12, gap: 8},
  label: {color: '#94A3B8', fontSize: 12, marginBottom: 2, marginTop: 4},
  input: {
    backgroundColor: '#0F172A',
    borderRadius: 8,
    color: '#F1F5F9',
    fontSize: 13,
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderWidth: 1,
    borderColor: '#334155',
    marginBottom: 4,
  },
  row: {flexDirection: 'row', gap: 8},
  btn: {
    borderRadius: 8,
    paddingVertical: 10,
    paddingHorizontal: 14,
    alignItems: 'center',
    marginBottom: 4,
  },
  btnFlex: {flex: 1},
  btnText: {color: '#FFFFFF', fontSize: 13, fontWeight: '600'},
  logHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#334155',
  },
  logHint: {color: '#475569', fontSize: 11},
  clearBtn: {color: '#60A5FA', fontSize: 12, fontWeight: '600'},
  logBox: {height: 260, paddingHorizontal: 10, paddingVertical: 6},
  logEmpty: {color: '#475569', fontSize: 12, textAlign: 'center', marginTop: 20},
  logRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginBottom: 4,
    gap: 4,
  },
  logTime: {color: '#475569', fontSize: 11, fontFamily: Platform.OS === 'ios' ? 'Menlo' : 'monospace'},
  logTag: {fontSize: 11, fontWeight: '700', fontFamily: Platform.OS === 'ios' ? 'Menlo' : 'monospace'},
  logMsg: {color: '#CBD5E1', fontSize: 11, flex: 1, flexWrap: 'wrap', fontFamily: Platform.OS === 'ios' ? 'Menlo' : 'monospace'},
});
